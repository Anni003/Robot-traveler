local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )
    local sceneGroup = self.view
        display.setStatusBar(display.HiddenStatusBar)
        display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/test.png", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)
end

scene:addEventListener("create", scene);
return scene;
    