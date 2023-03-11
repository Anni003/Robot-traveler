local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


function scene:create( event )
	local sceneGroup = self.view

	local bigTextText = "Поздравляю!"
	local bigText = display.newText( bigTextText, 0, 0, 350, 0, "native.systemFont", 45)
    bigText:setTextColor( 255, 255, 255 )
    bigText.x = display.contentCenterX + 400
	bigText.y = display.contentHeight - 400
	sceneGroup:insert(bigText)


    local lotsOfText = "Ты собрал картинку!" 
    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 700, 0, "native.systemFont", 45)
    lotsOfTextObject:setTextColor( 255, 255, 255 )
    lotsOfTextObject.x = display.contentCenterX + 500
	lotsOfTextObject.y = display.contentHeight - 320
	sceneGroup:insert(lotsOfTextObject)


	local function onPlayBtnRelease()

		composer.gotoScene( "scenes.three_doors", "fade", 400 )

		return true	-- indicates successful touch
	end

	menuTransBtn = widget.newButton {
		label = "",
		fontSize = 40,
		labelColor = { default={ 255.0 }, over={ 255.0 } },
		defaultFile = "puzzles folder/dif-images/v-menu.png",
		overFile = "puzzles folder/dif-images/v-menu.png",
		width = 250, height = 80,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	menuTransBtn.x = display.contentCenterX + 390
	menuTransBtn.y = display.contentHeight - 220



	sceneGroup:insert(menuTransBtn)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene