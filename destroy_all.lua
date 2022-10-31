local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

local function onPlayBtnRelease()
    composer.gotoScene("test");
	return true
end

function scene:create( event )
    local backgroud_black = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
            backgroud_black:setFillColor(0, 0, 0, 0.8)
    local people = display.newImageRect("img/people.png", display.contentCenterX/3, display.contentCenterY/0.6);
        people.x = display.contentCenterX/0.6;
        people.y = display.contentCenterY;
    local text_facts = 
    {
        text = "Вы собрали все предметы!\n\nА вы знали, что...Американский инженер Д. Уэксли представил \nпервого робота на Всемирной выставке 1927 года в Нью-Йорке. \nРобот мог выполнять команды человека, воспроизводя \nфразы и совершая простые движения.",     
        x = display.contentCenterX,
        y = display.contentCenterY/1.4,
        width = display.contentCenterX/1.1,
        font = native.systemFont,   
        fontSize = 12,
        align = "center"  
    }
    local text_all = display.newText(text_facts)
    text_all:setFillColor(255, 255, 255)
    nextBtn = widget.newButton {
        shape = 'roundedRect', 
        width = display.contentCenterX/1.2, height = display.contentCenterY/4, 
        x = display.contentCenterX,
        y = display.contentCenterY/0.7, 
        fontSize = 14, -- Размер шрифта
        fillColor = { default={ 76 / 255 }, over={ 150 / 255 } }, 
        labelColor = { default={ 1 }, over={ 0 } }, 
        label = "Вернуться к выбору уровня",
        onRelease = onPlayBtnRelease
    }
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