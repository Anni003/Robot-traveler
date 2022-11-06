local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view


    local volumeMusicText = display.newText( "Громкость музыки", 60,  160, "geometria_medium", 20 )
    volumeMusicText:setFillColor( 0, 0, 0 )


    if editVolume == false then
        valueOfMusic = 5
    end
    
    -- Ползунок звука
    local slider = widget.newSlider(
        {
            x = display.contentCenterX - 60,
            y = display.contentCenterY + 50,
            width = 400,

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

    
    local title = display.newText( "Настройки", 60, 80, "geometria_bold", 30 )
    title:setFillColor( 0, 0, 0 )


	local rect = display.newRect(sceneGroup, display.contentCenterX,
    display.contentCenterY, display.contentWidth + 350,
    display.contentHeight + 150):setFillColor(255, 255, 255, 1)
	


    local closeBtn = widget.newButton {
        defaultFile = "close.png",
        overFile = "close-over.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }
    closeBtn.x = display.contentWidth - 20
	closeBtn.y = display.contentHeight - 292


    sceneGroup:insert(title)
    sceneGroup:insert(closeBtn)
    sceneGroup:insert(slider)
    sceneGroup:insert(volumeMusicText)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene