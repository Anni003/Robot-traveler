local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

    
    local title = display.newText( "Справка", 60, 80, "geometria_bold", 30 )
    title:setFillColor( 0, 0, 0 )


	local rect = display.newRect(sceneGroup, display.contentCenterX,
    display.contentCenterY, display.contentWidth + 350,
    display.contentHeight + 150):setFillColor(255, 255, 255, 1)


    local textHowPlay = widget.newButton{
		label = "как играть",
		fontSize = 20,
		font = "geometria_medium",
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
		defaultFile = "background.png",
		overFile = "background.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("howPlay", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	textHowPlay.x = display.contentCenterX
	textHowPlay.y = display.contentHeight - 180


	local aboutGameBtn = widget.newButton{
		label = "команда разработки",
		font = "geometria_medium",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
		defaultFile = "background.png",
		overFile = "background.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("abGame", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	aboutGameBtn.x = display.contentCenterX
	aboutGameBtn.y = display.contentHeight - 120


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
    sceneGroup:insert(textHowPlay)
    sceneGroup:insert(aboutGameBtn)
    sceneGroup:insert(closeBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene