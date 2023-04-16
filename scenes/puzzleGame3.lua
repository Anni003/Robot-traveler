
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

--------------------------------------------
bgMusicPuz = audio.loadStream( "menu-folder/music/jumpshot.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )

audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука



function scene:create( event )
	local sceneGroup = self.view

	-- просто задний фон
	local background = display.newImageRect( "puzzles folder/dif-images/puzzles-fon.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	sceneGroup:insert( background )


	titleOfPuzzle = widget.newButton {
		label = "Собери картинку!",
		fontSize = 50,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "puzzles folder/dif-images/btn-soberu.png",
		overFile = "puzzles folder/dif-images/btn-soberu.png",
		width = 460, height = 110,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	titleOfPuzzle.x = display.contentCenterX - 280
	titleOfPuzzle.y = display.contentHeight - 650
	sceneGroup:insert( titleOfPuzzle )



	local desk = display.newImageRect( "puzzles folder/dif-images/podlozhka.png", 750, 507 )
	desk.x = 240
	desk.y = 450 --доска для пазлов
	sceneGroup:insert( desk ) 


-- 1 строка
local imgPart1 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_001.jpg", 180, 159 )
imgPart1.x = 743 + 180 - 30
imgPart1.y = 104 + 318 + 30
sceneGroup:insert( imgPart1 ) -- координаты x,y (1,1)

local imgPart2 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_002.jpg", 180, 159 )
imgPart2.x = 743 - 30
imgPart2.y = 104 + 30
sceneGroup:insert( imgPart2 ) -- координаты x,y (2,1)--голова

local imgPart3 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_003.jpg", 180, 159 )
imgPart3.x = 743 + 360 - 30
imgPart3.y = 104 + 159 + 30
sceneGroup:insert( imgPart3 ) -- координаты x,y (3,1)

local imgPart4 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_004.jpg", 180, 159 )
imgPart4.x = 743 - 30
imgPart4.y = 104 + 318 + 30
sceneGroup:insert( imgPart4 ) -- координаты x,y (1,2)

-- 2 строка

local imgPart5 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_005.jpg", 180, 159 )
imgPart5.x = 743 + 360 -30
imgPart5.y = 104+ 30
sceneGroup:insert( imgPart5 ) -- координаты x,y (2,2)

local imgPart6 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_006.jpg", 180, 159 )
imgPart6.x = 743 - 30
imgPart6.y = 104 + 159 + 30
sceneGroup:insert( imgPart6 ) -- координаты x,y (3,2)

local imgPart7 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_007.jpg", 180, 159 )
imgPart7.x = 743 + 180 - 30
imgPart7.y = 104 + 477 + 30
sceneGroup:insert( imgPart7 ) -- координаты x,y (1,3)

local imgPart8 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_008.jpg", 180, 159 )
imgPart8.x = 743 + 180 - 30
imgPart8.y = 104 + 159 + 30
sceneGroup:insert( imgPart8 ) -- координаты x,y (2,3)

-- 3 строка

local imgPart9 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_009.jpg", 180, 159 )
imgPart9.x = 743 + 360 - 30
imgPart9.y = 104 + 318 + 30
sceneGroup:insert( imgPart9 ) -- координаты x,y (3,3)

local imgPart10 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_010.jpg", 180, 159 )
imgPart10.x = 743 + 180 - 30
imgPart10.y = 104 + 30
sceneGroup:insert( imgPart10 ) -- координаты x,y (1,4)

local imgPart11 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_011.jpg", 180, 159 )
imgPart11.x = 743 - 30
imgPart11.y = 104 + 477 + 30
sceneGroup:insert( imgPart11 ) -- координаты x,y (2,4)

local imgPart12 = display.newImageRect( "puzzles folder/img-parts-for-puz-3/image_part_012.jpg", 180, 159 )
imgPart12.x = 743 + 360 - 30
imgPart12.y = 104 + 477 + 30
sceneGroup:insert( imgPart12 ) -- координаты x,y (3,4)



moveMassive = { 1, 1, 1,1, 1, 1,1, 1, 1,1, 1, 1 } -- массив для отслеживания, что один из пазлов двигается
-- ВСего 12 пазликов, если у пазлика 1 - ему двигаться можно. 0 - нельзя

local function changeMoveMassive(numberPuzzle) -- функция для обнуления движенпия всех пазлов, кроме одного

	for i = 1, 12 do -- цикл от 1 до 12 с шагом 1
			if (numberPuzzle == i) then
				moveMassive[i] = 1
			else
				moveMassive[i] = 0
			end
	end
end


local function permissionMove()
		for i = 1, 12 do -- цикл от 1 до 12 с шагом 1
			moveMassive[i] = 1
		end
end

local summaPuzzleFinish = 0 --сумма пазлов, которые на своем месте


-- функции перемещения------------------------------------------------------------------------------------------------
	local function movePuzzle1( event ) -- функция перемещения пазла
	
		if ( (event.phase == "moved") and (moveMassive[1] == 1) and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			changeMoveMassive(1) --меняем массив, останавливая другие пазлы	
			imgPart1:toFront()	
			imgPart1.x = event.x
			imgPart1.y = event.y

			-- display.contentWidth

			if ( ((-40) < event.x) and (event.x < (-20)) and (280 < event.y) and (event.y < 300)) then --если пазла близка к своему месту
				imgPart1.x = -30
				imgPart1.y = 290 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[1] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[1] = 0
				imgPart1:removeEventListener( "touch", movePuzzle1 ) -- слушатель касания => перемещение пазла 10
			end
		----eлсе если игрое вышел за пределы
		elseif ( (moveMassive[1] == 1) and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[1] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end



	local function movePuzzle2( event ) -- функция перемещения пазла
	
	if ( (event.phase == "moved") and (moveMassive[2] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770))  then
		imgPart2:toFront()	
		changeMoveMassive(2) --меняем массив, останавливая другие пазлы
		imgPart2.x = event.x
		imgPart2.y = event.y

		if ( ((140) < event.x) and (event.x < 160) and (280 < event.y) and (event.y < 300)) then --если пазла близка к своему месту
			imgPart2.x = 150
			imgPart2.y =  290 --около этого числа
			summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
			if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
				print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

				lptions = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
			end
			moveMassive[2] = 0
			permissionMove() --цифра для отмена запретов
			moveMassive[2] = 0
			imgPart2:removeEventListener( "touch", movePuzzle2 ) -- слушатель касания => перемещение пазла 10
		end
	elseif (moveMassive[2] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
		permissionMove()
	end

		if ( event.phase == "ended" and (moveMassive[2] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return

		end
	end


	local function movePuzzle3( event ) -- функция перемещения пазла

	if ( (event.phase == "moved") and (moveMassive[3] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
		imgPart3:toFront()	
		changeMoveMassive(3) --меняем массив, останавливая другие пазлы
		imgPart3.x = event.x
		imgPart3.y = event.y

		if ( ((320) < event.x) and (event.x < 340) and (280 < event.y) and (event.y < 300)) then --если пазла близка к своему месту
			imgPart3.x = 330
			imgPart3.y = 290 --около этого числа
			summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
			if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
				print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

				options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
			end
			moveMassive[3] = 0
			permissionMove() --цифра для отмена запретов
			moveMassive[3] = 0
			imgPart3:removeEventListener( "touch", movePuzzle3 ) -- слушатель касания => перемещение пазла 3
		end
	elseif (moveMassive[3] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
		permissionMove()
	end

		if ( event.phase == "ended" and (moveMassive[3] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle4( event ) -- функция перемещения пазла
	
		if ( (event.phase == "moved") and (moveMassive[4] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart4:toFront()	
			changeMoveMassive(4) --меняем массив, останавливая другие пазлы
			imgPart4.x = event.x
			imgPart4.y = event.y

			if ( ((500) < event.x) and (event.x < 520) and (280 < event.y) and (event.y < 300)) then --если пазла близка к своему месту
				imgPart4.x = 510
				imgPart4.y =  290 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[4] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[4] = 0
				imgPart4:removeEventListener( "touch", movePuzzle4 ) -- слушатель касания => перемещение пазла 10
			end
		elseif (moveMassive[4] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[4] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle5( event ) -- функция перемещения пазла
		
		if ( (event.phase == "moved") and (moveMassive[5] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart5:toFront()	
			changeMoveMassive(5) --меняем массив, останавливая другие пазлы
			imgPart5.x = event.x
			imgPart5.y = event.y

			if ( ((-40) < event.x) and (event.x < (-20)) and (439 < event.y) and (event.y < 459)) then --если пазла близка к своему месту
				imgPart5.x = -30
				imgPart5.y =  449 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[5] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[5] = 0
				imgPart5:removeEventListener( "touch", movePuzzle5 ) -- слушатель касания => перемещение пазла 5
			end
		elseif (moveMassive[5] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[5] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle6( event ) -- функция перемещения пазла

		if ( (event.phase == "moved") and (moveMassive[6] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart6:toFront()	
			changeMoveMassive(6) --меняем массив, останавливая другие пазлы
			imgPart6.x = event.x
			imgPart6.y = event.y
			if ( ((140) < event.x) and (event.x < 160) and (439 < event.y) and (event.y < 459)) then --если пазла близка к своему месту
				imgPart6.x = 150
				imgPart6.y =  449 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[6] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[6] = 0
				imgPart6:removeEventListener( "touch", movePuzzle6 ) -- слушатель касания => перемещение пазла 6
			end
		elseif (moveMassive[6] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[6] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle7( event ) -- функция перемещения пазла

		if ( (event.phase == "moved") and (moveMassive[7] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart7:toFront()	
			changeMoveMassive(7) --меняем массив, останавливая другие пазлы
			imgPart7.x = event.x
			imgPart7.y = event.y
		
			if ( ((320) < event.x) and (event.x < 340) and (439 < event.y) and (event.y < 459)) then --если пазла близка к своему месту
				imgPart7.x = 330
				imgPart7.y = 449 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[7] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[7] = 0
				imgPart7:removeEventListener( "touch", movePuzzle7 ) -- слушатель касания => перемещение пазла 7
			end
		elseif (moveMassive[7] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[7] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle8( event ) -- функция перемещения пазла

		if ( (event.phase == "moved") and (moveMassive[8] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart8:toFront()	
			changeMoveMassive(8) --меняем массив, останавливая другие пазлы
			imgPart8.x = event.x
			imgPart8.y = event.y
		
			if ( ((500) < event.x) and (event.x < 520) and (439 < event.y) and (event.y < 459)) then --если пазла близка к своему месту
				imgPart8.x = 510
				imgPart8.y = 449 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[8] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[8] = 0
				imgPart8:removeEventListener( "touch", movePuzzle8 ) -- слушатель касания => перемещение пазла 8
			end
		elseif (moveMassive[8] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[8 ] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end

	local function movePuzzle9( event ) -- функция перемещения пазла
	
		if ( (event.phase == "moved") and (moveMassive[9] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart9:toFront()	
			changeMoveMassive(9) --меняем массив, останавливая другие пазлы
			imgPart9.x = event.x
			imgPart9.y = event.y
		
			if ( ((-40) < event.x) and (event.x < (-20)) and (598 < event.y) and (event.y < 618)) then --если пазла близка к своему месту
				imgPart9.x = -30
				imgPart9.y = 608 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[9] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[9] = 0
				imgPart9:removeEventListener( "touch", movePuzzle9 ) -- слушатель касания => перемещение пазла 9
			end
		elseif (moveMassive[9] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
		permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[9] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle10( event ) -- функция перемещения пазла

		if ( (event.phase == "moved") and (moveMassive[10] == 1) and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770) ) then
			imgPart10:toFront()	
			changeMoveMassive(10) --меняем массив, останавливая другие пазлы
			imgPart10.x = event.x
			imgPart10.y = event.y

			if ( ((140) < event.x) and (event.x < 160) and (598 < event.y) and (event.y < 618) ) then --если пазла близка к своему месту
				imgPart10.x = 150
				imgPart10.y = 608 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[10] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[10] = 0
				imgPart10:removeEventListener( "touch", movePuzzle10 ) -- слушатель касания => перемещение пазла 10
			end
		elseif (moveMassive[10] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[10] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle11( event ) -- функция перемещения пазла

		if ( (event.phase == "moved") and (moveMassive[11] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart11:toFront()	
			changeMoveMassive(11) --меняем массив, останавливая другие пазлы
			imgPart11.x = event.x
			imgPart11.y = event.y
		
			if ( ((320) < event.x) and (event.x < 340) and (598 < event.y) and (event.y < 618) ) then --если пазла близка к своему месту
				imgPart11.x = 330
				imgPart11.y =  608 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )
					
				end
				moveMassive[11] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[11] = 0
				imgPart11:removeEventListener( "touch", movePuzzle11 ) -- слушатель касания => перемещение пазла 11
			end
		elseif (moveMassive[11] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[11] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end


	local function movePuzzle12( event ) -- функция перемещения пазла
		if ( (event.phase == "moved") and (moveMassive[12] == 1)  and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-160 )) and (event.x < (display.viewableContentWidth + 160)) and (event.y>-3) and (event.y<770)) then
			imgPart12:toFront()	
			changeMoveMassive(12) --меняем массив, останавливая другие пазлы
			imgPart12.x = event.x
			imgPart12.y = event.y
		
			if ( ((500) < event.x) and (event.x < 520) and (598 < event.y) and (event.y < 618) ) then --если пазла близка к своему месту
				imgPart12.x = 510
				imgPart12.y =  608 --около этого числа
				summaPuzzleFinish = summaPuzzleFinish + 1 -- + один пазл на месте
				if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
					print("ВСЕ ВСЕ ВСЕ ВСЕ ВСЕ")

					options = {
		    			isModal = true,
	    				effect = "fade",
	    				time = 400
					}
 
					-- By some method such as a "pause" button, show the overlay
						composer.showOverlay( "puzzles folder.modalComponents.referenceModal", options )

					
				end
				moveMassive[12] = 0
				permissionMove() --цифра для отмена запретов
				moveMassive[12] = 0
				imgPart12:removeEventListener( "touch", movePuzzle12 ) -- слушатель касания => перемещение пазла 12
			end
		elseif (moveMassive[12] == 1 and   ( (event.x<=-320) or (event.x>=1340) or (event.y<=-3) or (event.y>=770) )  ) then
			permissionMove()
		end

		if ( event.phase == "ended" and (moveMassive[12] == 1)) then
			permissionMove() --цифра для отмена запретов
			return
		else
			return
		end
	end




--секундомер

	sec = widget.newButton {
		label = good_time,
		fontSize = 40,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "puzzles folder/dif-images/btn-soberu.png",
		overFile = "puzzles folder/dif-images/btn-soberu.png",
		width = 110, height = 110,
	}
	sec.x = display.contentCenterX + 5
	sec.y = display.contentHeight - 650
	sceneGroup:insert( sec )



	local t = {}
	function t:timer( event )
		local count = event.count
		sec:setLabel( event.count )

		if (summaPuzzleFinish == 12) then
			timer.cancel( event.source ) -- after 3rd invocation, cancel timer
		end
	end
	
	timer.performWithDelay( 1000, t, 0 )



	

	imgPart1:addEventListener( "touch", movePuzzle1 ) -- слушатель касания => перемещение пазла 1
	imgPart2:addEventListener( "touch", movePuzzle2 ) -- слушатель касания => перемещение пазла 2
	imgPart3:addEventListener( "touch", movePuzzle3 ) -- слушатель касания => перемещение пазла 3
	imgPart4:addEventListener( "touch", movePuzzle4 ) -- слушатель касания => перемещение пазла 4
	imgPart5:addEventListener( "touch", movePuzzle5 ) -- слушатель касания => перемещение пазла 5
	imgPart6:addEventListener( "touch", movePuzzle6 ) -- слушатель касания => перемещение пазла 6
	imgPart7:addEventListener( "touch", movePuzzle7 ) -- слушатель касания => перемещение пазла 7
	imgPart8:addEventListener( "touch", movePuzzle8 ) -- слушатель касания => перемещение пазла 8
	imgPart9:addEventListener( "touch", movePuzzle9 ) -- слушатель касания => перемещение пазла 9
	imgPart10:addEventListener( "touch", movePuzzle10 ) -- слушатель касания => перемещение пазла 10
	imgPart11:addEventListener( "touch", movePuzzle11 ) -- слушатель касания => перемещение пазла 11
	imgPart12:addEventListener( "touch", movePuzzle12 ) -- слушатель касания => перемещение пазла 12
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "did" then

		if musicGlobal == true then
			timer.performWithDelay( 5, function()
				audio.play( bgMusicPuz, { loops = -1, channel = 1 } ) -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
				-- audio.fade({ channel = 1, time = 100, volume = 0.1 } )
			end)
		end
	end	
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then
		
		if musicGlobal == true then
			-- audio.fadeOut( { channel = 2, time = 1500 } )
			audio.stop( 1 )    -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ
		end

	end	

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop(1)  -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ

end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-----------------------------------------------------------------------------------------

return scene