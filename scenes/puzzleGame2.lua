
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

--------------------------------------------
bgMusicPuz2 = audio.loadStream( "menu-folder/music/jumpshot.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )

if(musicGlobal) then
	audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука
end

function scene:create( event )


	local sceneGroup = self.view

	-- просто задний фон
	local background = display.newImageRect( "puzzles folder/dif-images/puzzles-fon.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	sceneGroup:insert( background )
	menubtn = widget.newButton({
        label = "",
        --font = "fonts/geometria_medium",
        labelColor = { default={ 0.0 }, over={ 0.0 } },
        defaultFile = "img/menu.png",
        overFile = "img/menu.png",
        width = 200, height = 200,
        x = display.viewableContentWidth-100,
        y = 150,
        fontSize = 18,
        onRelease=function(event)
            composer.gotoScene( "menu", "fade", 400 )
        end	
    }) 
    sceneGroup:insert(menubtn)

	local myText = display.newText( "Собери картинку!", display.contentCenterX - 100, display.contentCenterY - 400, "fonts/geometria_medium", 50 )
	myText:setFillColor( 1, 1, 1 )
	sceneGroup:insert( myText )


	local desk = display.newImageRect( "puzzles folder/dif-images/podlozhka-lines.png", 837, 555)
	desk.x = 480
	desk.y = 600 --доска для пазлов
	sceneGroup:insert( desk ) 


-- 1 строка
local imgPart3 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_003.jpg", 210, 185 )
imgPart3.x = 1124
imgPart3.y = 414
sceneGroup:insert( imgPart3 ) -- координаты x,y (1,1)

local imgPart7 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_007.jpg", 210, 185 )
imgPart7.x = 1334
imgPart7.y = 414
sceneGroup:insert( imgPart7 ) -- координаты x,y (2,1)--голова

local imgPart10 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_010.jpg", 210, 185 )
imgPart10.x = 1544
imgPart10.y = 414
sceneGroup:insert( imgPart10 ) -- координаты x,y (3,1)

local imgPart2 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_002.jpg", 210, 185 )
imgPart2.x = 1754
imgPart2.y = 414
sceneGroup:insert( imgPart2 ) -- координаты x,y (1,2)

-- 2 строка

local imgPart9 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_009.jpg", 210, 185 )
imgPart9.x = 1124
imgPart9.y = 599
sceneGroup:insert( imgPart9 ) -- координаты x,y (2,2)

local imgPart5 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_005.jpg", 210, 185 )
imgPart5.x = 1334
imgPart5.y = 599
sceneGroup:insert( imgPart5 ) -- координаты x,y (3,2)

local imgPart12 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_012.jpg", 210, 185 )
imgPart12.x = 1544
imgPart12.y = 599
sceneGroup:insert( imgPart12 ) -- координаты x,y (1,3)

local imgPart8 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_008.jpg", 210, 185 )
imgPart8.x = 1754
imgPart8.y = 599
sceneGroup:insert( imgPart8 ) -- координаты x,y (2,3)

-- 3 строка

local imgPart4 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_004.jpg", 210, 185 )
imgPart4.x = 1124
imgPart4.y = 784
sceneGroup:insert( imgPart4 ) -- координаты x,y (3,3)

local imgPart1 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_001.jpg", 210, 185 )
imgPart1.x = 1334
imgPart1.y = 784
sceneGroup:insert( imgPart1 ) -- координаты x,y (1,4)

local imgPart6 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_006.jpg", 210, 185 )
imgPart6.x = 1544
imgPart6.y = 784
sceneGroup:insert( imgPart6 ) -- координаты x,y (2,4)

local imgPart11 = display.newImageRect( "puzzles folder/img-parts-for-puz-2/image_part_011.jpg", 210, 185 )
imgPart11.x = 1754
imgPart11.y = 784
sceneGroup:insert( imgPart11 ) -- координаты x,y (3,4)


deskCellsX={164,374,584,794,164,374,584,794,164,374,584,794}
deskCellsY={414,414,414,414,599,599,599,599,784,784,784,784}
puzzleImages={imgPart1,imgPart2,imgPart3,imgPart4,imgPart5,imgPart6,imgPart7,imgPart8,imgPart9,imgPart10,imgPart11,imgPart12}

cellMagnetDistance=60
local function NearDeskCell(x,y)
	cellnumber=0
	for i=1,12 do
		if ( (deskCellsX[i]-cellMagnetDistance < x) and (deskCellsX[i]+cellMagnetDistance > x) and (deskCellsY[i]-cellMagnetDistance < y) and (deskCellsY[i]+cellMagnetDistance > y)) then
			cellnumber= i
		end
	end
	return cellnumber
end

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
local function IsFinished()
	print("ВСЕ "..summaPuzzleFinish)
	if (summaPuzzleFinish == 12) then -- проверка на собранную картинку
		composer.showOverlay("scenes.puzzle_all", {
			isModal=true,
			effect="fade",
			time=400,
		})
		
	end
end
local function movePuzzles( event) -- функция перемещения пазла
	puzlenum=event.target.id
	if ( event.phase == "began" ) then
		
		print("Touch event began on: " .. puzlenum)
	end
	
	if ( (event.phase == "moved") and (moveMassive[puzlenum] == 1) and (event.x>((display.viewableContentWidth - display.viewableContentWidth)-80 )) and (event.x < (display.viewableContentWidth + 80)) and (event.y>-3) and (event.y<1150)) then
		changeMoveMassive(puzlenum) --меняем массив, останавливая другие пазлы	
		puzzleImages[puzlenum]:toFront()	
		puzzleImages[puzlenum].x = event.x
		puzzleImages[puzlenum].y = event.y
	end

	if ( event.phase == "ended" and (moveMassive[puzlenum] == 1)) then
		cellNum = NearDeskCell(event.x,event.y)
		if cellNum >0 then
			puzzleImages[puzlenum].x = deskCellsX[cellNum]
			puzzleImages[puzlenum].y = deskCellsY[cellNum]  
			moveMassive[1] = 0
			permissionMove()
			moveMassive[1] = 0
		end
		if cellNum==puzlenum then
			summaPuzzleFinish=summaPuzzleFinish+1
			IsFinished()
			puzzleImages[puzlenum]:removeEventListener( "touch", movePuzzles ) -- слушатель касания => перемещение пазла 10
			
		end

		permissionMove() --цикл для отмены запретов
		return
	end
end
for i=1,12 do
    puzzleImages[i].id=i
	puzzleImages[i]:addEventListener( "touch", movePuzzles )
end

--секундомер

sec = widget.newButton {
	label = good_time,
	fontSize = 48,
	font = "fonts/geometria_medium",
	labelColor = { default={ 1.1 }, over={ 1.1 } },
	defaultFile = "puzzles folder/dif-images/secundomer.png",
	overFile = "puzzles folder/dif-images/secundomer.png",
	width = 110, height = 110,
}
sec.x = display.contentCenterX + 245
sec.y = display.contentCenterY - 400
sceneGroup:insert( sec )




local t = {}
function t:timer( event )
	local count = event.count
	sec:setLabel( event.count )

	if (summaPuzzleFinish == 12) then
		time_2 = event.count
		timer.cancel( event.source ) -- after 3rd invocation, cancel timer
	end
end

timer.performWithDelay( 1000, t, 0 )

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "did" then

		if musicGlobal == true then
			timer.performWithDelay( 5, function()
				audio.play( bgMusicPuz1, { loops = -1, channel = 1 } ) -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
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
			audio.stop(1)
		end

	end	

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.dispose( bgMusicPuz1 )

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )




-----------------------------------------------------------------------------------------

return scene