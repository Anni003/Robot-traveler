local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

	
    local lotsOfText = "Круто! Ты собрал картину. Поздравляю" 

    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 350, 0, "native.systemFont", 45)
    lotsOfTextObject:setTextColor( 0, 0, 0 )

    lotsOfTextObject.x = display.contentCenterX + 400
	lotsOfTextObject.y = display.contentHeight - 400



	local function onPlayBtnRelease()

		composer.gotoScene( "menu", "fade", 400 )

		return true	-- indicates successful touch
	end

	menuTransBtn = widget.newButton {
		label = "В меню",
		fontSize = 40,
		labelColor = { default={ 255.0 }, over={ 255.0 } },
		defaultFile = "puzzles folder/dif-images/button.png",
		overFile = "puzzles folder/dif-images/button.png",
		width = 250, height = 70,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	menuTransBtn.x = display.contentCenterX + 380
	menuTransBtn.y = display.contentHeight - 220





	sceneGroup:insert(lotsOfTextObject)
	sceneGroup:insert(menuTransBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene