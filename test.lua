local composer = require("composer");
local scene = composer.newScene(); -- создаём новую сцену
function scene:show(event)
    local backgroud = display.newImageRect("img/location_1.jpg", display.actualContentWidth, display.actualContentHeight)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY
end
scene:addEventListener("show", scene);
return scene;
