local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

    
    local title = display.newText( "Рейтинг", display.contentWidth - 500 , 160, "fonts/geometria_bold", 70 )
    title:setFillColor( 255, 255, 255 )


	local rect = display.newImageRect( "menu-folder/images-for-menu/rect-ref.png", display.contentWidth + 50, display.contentHeight - 100 )
	rect.x = display.contentCenterX
	rect.y = display.contentCenterY
	sceneGroup:insert( rect ) 

	

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
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene