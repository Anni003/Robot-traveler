local composer = require("composer")
local scene = composer.newScene()

local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view


    local rect = display.newRect(sceneGroup, display.contentCenterX,
    display.contentCenterY, display.contentWidth + 350,
    display.contentHeight + 150):setFillColor(37/255, 39/255, 46/255, 0.7)



    local newRoundedRect = widget.newScrollView 
    {
        top = 65,
        left = 0,
        right = 0,
        width = 900,
        horizontalScrollDisabled = true,
        backgroundColor={250,250,250, 1},

        topPadding = 500,
        bottomPadding5= 10, 
        leftPadding = 50, 
        rightPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = scrollListener
    }

    

    local okButton = widget.newButton {
        labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
        defaultFile = "menu-folder/images-for-menu/close.png",
        overFile = "menu-folder/images-for-menu/close-over.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }

    okButton.x = display.contentWidth - 20
	okButton.y = display.contentCenterY - 292



    sceneGroup:insert(okButton)
    sceneGroup:insert(newRoundedRect)
end

scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene