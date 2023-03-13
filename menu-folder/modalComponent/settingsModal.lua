local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view


    local title = display.newText( "Настройки", display.contentWidth - 500 , 160, "fonts/geometria_bold", 70 )
    title:setFillColor( 255, 255, 255 )


	local rect = display.newImageRect( "menu-folder/images-for-menu/rect-ref.png", display.contentWidth + 50, display.contentHeight - 100 )
	rect.x = display.contentCenterX
	rect.y = display.contentCenterY
	sceneGroup:insert( rect ) 


	local robot = display.newImageRect( "menu-folder/images-for-menu/robot.jpg", 270, 400 )
	robot.x = display.contentCenterX + 330
	robot.y = display.contentCenterY + 70
	sceneGroup:insert( robot ) 



    local volumeMusicText = display.newText( "Громкость музыки", 350,  380, "fonts/geometria_medium", 40 )
    volumeMusicText:setFillColor( 255, 255, 255 )


    if editVolume == false then
        valueOfMusic = 5
    end
    
    -- Ползунок звука
    local slider = widget.newSlider(
        {
            x = display.contentCenterX - 160,
            y = display.contentCenterY + 70,
            width = 370,

            value = valueOfMusic,

            listener = function( event )

                valueOfMusic = event.value

                editVolume = true
                
                if (event.value >= 0 and event.value < 10) then 
                    volumeGlobalMusic = 0.1
                    audio.setVolume( 0.1, { channel=1 } )
                elseif (event.value >= 10 and event.value < 20) then
                    volumeGlobalMusic = 0.2
                    audio.setVolume( 0.2, { channel=1 } )
                elseif (event.value >= 20 and event.value < 30) then
                    volumeGlobalMusic = 0.3
                    audio.setVolume( 0.3, { channel=1 } )
                elseif (event.value >= 30 and event.value < 40) then
                    volumeGlobalMusic = 0.4
                    audio.setVolume( 0.4, { channel=1 } )
                elseif (event.value >= 40 and event.value < 50) then
                    volumeGlobalMusic = 0.5
                    audio.setVolume( 0.5, { channel=1 } )
                elseif (event.value >= 50 and event.value < 60) then
                    volumeGlobalMusic = 0.6
                    audio.setVolume( 0.6, { channel=1 } )
                elseif (event.value >= 60 and event.value < 70) then
                    volumeGlobalMusic = 0.7
                    audio.setVolume( 0.7, { channel=1 } )
                elseif (event.value >= 70 and event.value < 80) then
                    volumeGlobalMusic = 0.8
                    audio.setVolume( 0.8, { channel=1 } )
                elseif (event.value >= 90 and event.value <= 100) then
                    volumeGlobalMusic = 0.9
                    audio.setVolume( 0.9, { channel=1 } )
                end
            end
        }
    )


    local closeBtn = widget.newButton {
        defaultFile = "menu-folder/images-for-menu/close-white-modal.png",
        overFile = "menu-folder/images-for-menu/close-white-modal.png",
        width = 50, height = 50,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }
    closeBtn.x = display.contentWidth - 150
	closeBtn.y = display.contentCenterY - 215


    sceneGroup:insert(title)
    sceneGroup:insert(closeBtn)
    sceneGroup:insert(slider)
    sceneGroup:insert(volumeMusicText)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene