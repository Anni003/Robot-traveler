local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local function onPlayBtnRelease()
    composer.gotoScene( "scenes.refresh", { params = { hero_x = 280, hero_y = 800, isClosed = true } }, "fade", 400 )
	return true
end

function scene:create( event )
    local sceneGroup = self.view
    local backgroud_black = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
        backgroud_black:setFillColor(0, 0, 0, 0.67)
    
    local background = display.newImageRect("img/back_blue.png", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY

            
    local text = display.newImageRect("img/text_fact.png", display.actualContentWidth/1.2, display.actualContentHeight/1.4)
        text.x = display.contentCenterX
        text.y = display.contentCenterY

    nextBtn = widget.newButton {
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "img/button_level.png",
		width = display.contentCenterX/0.8, 
        height = display.contentCenterY/3,
        onRelease = onPlayBtnRelease
    } 
    nextBtn.x = display.contentCenterX/1.3
    nextBtn.y = display.contentCenterY/0.68

    sceneGroup:insert(background)
    sceneGroup:insert(backgroud_black)
    sceneGroup:insert(text)
    sceneGroup:insert(nextBtn)
end

function scene:destroy( event )
	local sceneGroup = self.view
	if nextBtn then
		nextBtn:removeSelf()
		nextBtn = nil
	end
end

scene:addEventListener( "create", scene )
scene:addEventListener("destroy", scene);
return scene