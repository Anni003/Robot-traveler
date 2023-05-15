local composer = require( "composer" )

local scene = composer.newScene()

bgMusicDoors = audio.loadStream( "menu-folder/music/adventure.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )
audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука


function scene:create( event )
    local sceneGroup = self.view
        display.setStatusBar(display.HiddenStatusBar)
        display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/back_door_1.png", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

    local doors = display.newGroup()
        sceneGroup:insert(doors)

    local door_1 = display.newImageRect(doors, "img/door-1.png", 340, 520)
        door_1.x = display.contentCenterX
        door_1.y = display.contentCenterY/0.83
        sceneGroup:insert(door_1)

    -- local door_2 = display.newImageRect(doors, "img/door-2.png", 320, 490)
    --     door_2.x = display.contentCenterX
    --     door_2.y = display.contentCenterY/1.45
    --     sceneGroup:insert(door_2)

    -- local door_3 = display.newImageRect(doors, "img/door-3.png", 320, 490)
    --     door_3.x = display.contentCenterX/0.57
    --     door_3.y = display.contentCenterY/1.458
    --     sceneGroup:insert(door_3)

    
    local list = {"scenes.hidden_object3", "scenes.hidden_object"}

    -- local puzzleList = {"scenes.puzzleGame1", "scenes.puzzleGame2", "scenes.puzzleGame3"}

    local function open_door_1()
        local array = list[math.random(#list)]
        composer.gotoScene(array)
    end

    -- local function open_door_2()
    --     composer.gotoScene("scenes.labyrinth")
    -- end

    -- local function open_door_3()
    --     local arrayPuzzle = puzzleList[math.random(#puzzleList)]
    --     composer.gotoScene(arrayPuzzle)
    -- end
    
    door_1:addEventListener( "tap", open_door_1 )
    -- door_2:addEventListener( "tap", open_door_2 )
    -- door_3:addEventListener( "tap", open_door_3 )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "did" then

		if musicGlobal == true then
			timer.performWithDelay( 5, function()
				audio.play( bgMusicDoors, { loops = -1, channel = 1 } ) -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
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
			audio.stop( 1 )    -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ
		end

	end	

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop(1)  -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ

end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;
