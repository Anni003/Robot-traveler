local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

    
    local title = display.newText( "Справка", 85, 80, "fonts/geometria_bold", 60 )
    title:setFillColor( 0, 0, 0 )


	local rect = display.newRect(sceneGroup, display.contentCenterX,
    display.contentCenterY, display.contentWidth + 350,
    display.contentHeight + 150):setFillColor(255, 255, 255, 1)


    local textHowPlay = widget.newButton{
		label = "как играть",
		fontSize = 40,
		font = "fonts/geometria_medium",
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
		defaultFile = "menu-folder/images-for-menu/background.png",
		overFile = "menu-folder/images-for-menu/background.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.howPlay", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	textHowPlay.x = display.contentCenterX
	textHowPlay.y = display.contentCenterY


	local aboutGameBtn = widget.newButton{
		label = "команда разработки",
		font = "fonts/geometria_medium",
		fontSize = 40,
		labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
		defaultFile = "menu-folder/images-for-menu/background.png",
		overFile = "menu-folder/images-for-menu/background.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.abGame", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	aboutGameBtn.x = display.contentCenterX
	aboutGameBtn.y = display.contentCenterY + 100


    local closeBtn = widget.newButton {
        defaultFile = "menu-folder/images-for-menu/close.png",
        overFile = "menu-folder/images-for-menu/close-over.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }
    closeBtn.x = display.contentWidth - 20
	closeBtn.y = display.contentCenterY - 292


    sceneGroup:insert(title)
    sceneGroup:insert(textHowPlay)
    sceneGroup:insert(aboutGameBtn)
    sceneGroup:insert(closeBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene