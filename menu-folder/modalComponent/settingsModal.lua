local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view



	local rect = display.newImageRect( "menu-folder/images-for-menu/fon-settings.png", display.contentWidth + 340, display.contentHeight  )
	rect.x = display.contentCenterX
	rect.y = display.contentCenterY
	sceneGroup:insert( rect ) 



    if editVolume == false then
        valueOfMusic = 5
    end
    
    -- Ползунок звука
    local slider = widget.newSlider(
        {
            x = display.contentCenterX + 10,
            y = display.contentCenterY + 105,
            width = 650,

            value = valueOfMusic,

            listener = function( event )

                valueOfMusic = event.value

                editVolume = true
                
                if (event.value >= 0 and event.value < 4) then 
                    volumeGlobalMusic = 0
                    audio.setVolume( 0, { channel=1 } )

                elseif (event.value >= 4 and event.value < 10) then
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
        defaultFile = "menu-folder/images-for-menu/close-krest-simple.png",
        overFile = "menu-folder/images-for-menu/close-krest-simple.png",
        width = 85, height = 85,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }
    closeBtn.x = display.contentWidth + 40
	closeBtn.y = display.contentCenterY + 275


    sceneGroup:insert(closeBtn)
    sceneGroup:insert(slider)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene