local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

bgMusicDoors = audio.loadStream( "menu-folder/music/adventure.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )
if(musicGlobal) then
	audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука
end
local function inMenu()
    composer.removeScene("scenes.hidden_object")
    composer.removeScene("scenes.hidden_object3")
    composer.removeScene("scenes.puzzleGame1")
    composer.removeScene("scenes.puzzleGame2")
    composer.removeScene("scenes.puzzleGame3")
    composer.removeScene("scenes.labyrinth")
    composer.removeScene("scenes.times")
    composer.gotoScene( "menu" )
end

function scene:create( event )
    local sceneGroup = self.view
    local background = display.newImageRect("img/Fon_glavnoe_menyu.png", display.actualContentWidth, display.actualContentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)

    local back_1 = display.newRoundedRect(display.contentCenterX/0.945, display.contentCenterY/1.3, 1050, 190, 25)
    back_1:setFillColor(0, 0, 0, 0.6)
    sceneGroup:insert(back_1)

    local timer = display.newImageRect("img/time.png", 200, 200)
    timer.x = display.contentCenterX/1.8
    timer.y = display.contentCenterY/1.3
    sceneGroup:insert(timer)

    local text_time = display.newText("Вы прошли 1 уровень за "..time_1.." секунд", display.contentCenterX/0.9, display.contentCenterY/1.3, "fonts/geometria_medium", 48)
    sceneGroup:insert(text_time)

    local back_2 = display.newRoundedRect(display.contentCenterX/0.945, display.contentCenterY/0.88, 1050, 190, 25)
    back_2:setFillColor(0, 0, 0, 0.6)
    sceneGroup:insert(back_2)

    local timer2 = display.newImageRect("img/time.png", 200, 200)
    timer2.x = display.contentCenterX/1.8
    timer2.y = display.contentCenterY/0.88
    sceneGroup:insert(timer2)

    local text_time2 = display.newText("Вы прошли 2 уровень за "..time_2.." секунд", display.contentCenterX/0.9, display.contentCenterY/0.88, "fonts/geometria_medium", 48)
    sceneGroup:insert(text_time2)

    local back_3 = display.newRoundedRect(display.contentCenterX/0.945, display.contentCenterY/0.66, 1050, 190, 25)
    back_3:setFillColor(0, 0, 0, 0.6)
    sceneGroup:insert(back_3)

    local timer3 = display.newImageRect("img/time.png", 200, 200)
    timer3.x = display.contentCenterX/1.8
    timer3.y = display.contentCenterY/0.66
    sceneGroup:insert(timer3)

    local text_time3 = display.newText("Вы прошли 3 уровень за "..time_3.." секунд", display.contentCenterX/0.9, display.contentCenterY/0.66, "fonts/geometria_medium", 48)
    sceneGroup:insert(text_time3)

    btnMenu = widget.newButton {
		label = "В меню",
		fontSize = 48,
		labelColor = { default={ 1 }, over={ 1 } },
		width = 450, height = 120,
        shape = "roundedRect",
        fillColor = { default={ 1, 0.44, 0 }, over={ 1, 0.34, 0 } },
        cornerRadius = 25,
        onEvent = inMenu
	}
	btnMenu.x = display.contentCenterX
	btnMenu.y = display.contentCenterY/0.55
    sceneGroup:insert(btnMenu)

end


function scene:show( event )
end

function scene:hide( event )
end

function scene:destroy( event )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;