local composer = require("composer");
local scene = composer.newScene(); -- создаём новую сцену
function scene:show(event)
    local backgroud = display.newImageRect("white.jpg", display.contentWidth, display.contentHeight)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY
end
scene:addEventListener("show", scene);
return scene;