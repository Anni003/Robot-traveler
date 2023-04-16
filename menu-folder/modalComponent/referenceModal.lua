local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

    
    local title = display.newText( "Справка", display.contentWidth - 500 , 160, "fonts/geometria_bold", 70 )
    title:setFillColor( 255, 255, 255 )


	local rect = display.newImageRect( "menu-folder/images-for-menu/rect-ref.png", display.contentWidth + 50, display.contentHeight - 100 )
	rect.x = display.contentCenterX
	rect.y = display.contentCenterY
	sceneGroup:insert( rect ) 

	
	local picture = display.newImageRect( "menu-folder/images-for-menu/ref-picture.png", 240, 270 )
	picture.x = display.contentCenterX - 370
	picture.y = display.contentCenterY - 90
	sceneGroup:insert( picture ) 


    local textHowPlay = widget.newButton{
		label = "Как играть",
		fontSize = 42,
		font = "fonts/geometria_medium",
		labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255 } },
		labelYOffset = 10,
		defaultFile = "menu-folder/images-for-menu/btn1-ref.png",
		overFile = "menu-folder/images-for-menu/btn1-ref.png",
		width = 700, height = 120,
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
		label = "Команда разработки",
		font = "fonts/geometria_medium",
		fontSize = 42,
		labelYOffset = -20,
		labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255 } },
		defaultFile = "menu-folder/images-for-menu/btn2-ref.png",
		overFile = "menu-folder/images-for-menu/btn2-ref.png",
		width = 700, height = 120,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.abGame", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	aboutGameBtn.x = display.contentCenterX
	aboutGameBtn.y = display.contentCenterY + 120


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
    sceneGroup:insert(textHowPlay)
    sceneGroup:insert(aboutGameBtn)
    sceneGroup:insert(closeBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene