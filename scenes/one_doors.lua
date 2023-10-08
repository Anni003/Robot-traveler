local composer = require( "composer" )

local scene = composer.newScene()

bgMusicDoors = audio.loadStream( "menu-folder/music/adventure.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )
if(musicGlobal) then
audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука
end

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

    local door_1 = display.newImageRect(doors, "img/door-1.png", 500, 800)
        door_1.x = display.contentCenterX
        door_1.y = display.contentCenterY/0.83
        sceneGroup:insert(door_1)

    
    local list = {"scenes.hidden_object3", "scenes.hidden_object"}

    local function open_door_1()
        local array = list[math.random(#list)]
        composer.gotoScene(array)
    end

    door_1:addEventListener( "tap", open_door_1 )
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
