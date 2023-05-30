local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view


	local rect = display.newImageRect( "menu-folder/images-for-menu/fon-spravka.png", display.contentWidth + 340, display.contentHeight )
	rect.x = display.contentCenterX
	rect.y = display.contentCenterY
	sceneGroup:insert( rect ) 


    local textHowPlay = widget.newButton{
		label = "",
		fontSize = 42,
		font = "fonts/geometria_medium",
		labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255 } },
		defaultFile = "menu-folder/images-for-menu/btn-how-play.png",
		overFile = "menu-folder/images-for-menu/btn-how-play.png",
		width = 650, height = 145,
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
		label = "",
		font = "fonts/geometria_medium",
		fontSize = 42,
		labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255 } },
		defaultFile = "menu-folder/images-for-menu/btn-group-of-creators.png",
		overFile = "menu-folder/images-for-menu/btn-group-of-creators.png",
		width = 750, height = 145,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.abGame", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	aboutGameBtn.x = display.contentCenterX
	aboutGameBtn.y = display.contentCenterY + 175


    local closeBtn = widget.newButton {
        defaultFile = "menu-folder/images-for-menu/close-krest-simple.png",
        overFile = "menu-folder/images-for-menu/close-krest-simple.png",
        width = 85, height = 85,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }
    closeBtn.x = display.contentWidth - 300
	closeBtn.y = display.contentCenterY - 250


    sceneGroup:insert(textHowPlay)
    sceneGroup:insert(aboutGameBtn)
    sceneGroup:insert(closeBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene