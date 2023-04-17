local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

local function onPlayBtnRelease()
    composer.gotoScene( "scenes.test")
	return true
end


function scene:create( event )
    local sceneGroup = self.view
        display.setStatusBar(display.HiddenStatusBar)
        display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/back_registration.jpg", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

        local numericField = native.newTextField( display.contentCenterX, display.contentCenterY/1.2, display.actualContentWidth/2, display.actualContentHeight/12)
        numericField.inputType = "number"
        sceneGroup:insert(numericField)

        local numericField2 = native.newTextField( display.contentCenterX, display.contentCenterY/0.9, display.actualContentWidth/2, display.actualContentHeight/12)
        sceneGroup:insert(numericField2)

        local nextBtn = widget.newButton {
            labelColor = { default={ 0.0 }, over={ 0.0 } },
            defaultFile = "img/button_level.png",
            width = display.contentCenterX/0.7, 
            height = display.contentCenterY/2.5,
            onRelease = onPlayBtnRelease
        } 
        nextBtn.x = display.contentCenterX
        nextBtn.y = display.contentCenterY/0.6
        sceneGroup:insert(nextBtn)
    
end

scene:addEventListener("create", scene);
return scene;
