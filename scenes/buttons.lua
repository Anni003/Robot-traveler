local widget = require("widget")
-- Определите несколько кнопок
local buttons = {}
buttons["soundOFFbtn"] = widget.newButton({
		label = "11111111111111111111111111111111111",
		x = 1000,
		y = 100,
		width = 200,
		height = 40,
		fontSize = 18,
		shape = "roundedRect",
		cornerRadius = 5,
		fillColor = { default = { 0.2, 0.2, 0.8 }, over = { 0.3, 0.3, 0.9 } },
		labelColor = { default = { 1, 1, 1 }, over = { 1, 1, 1 } },
		onRelease=function(event)
			if musicGlobal then
				musicGlobal=false
				audio.setVolume(0,{ channel=1 })
				soundOFFbtn:setLabel("SoundOFF")
			else
				musicGlobal=true
				audio.setVolume(volumeGlobalMusic,{ channel=1 })
				soundOFFbtn:setLabel("SoundON")
			end	
		end	
		
	})
	buttons["homebtn"] = widget.newButton({
		label = "dfgdfg",
		x = 300,
		y = 100,
		width = 200,
		height = 40,
		fontSize = 18,
		shape = "roundedRect",
		cornerRadius = 5,
		fillColor = { default = { 0.2, 0.2, 0.8 }, over = { 0.3, 0.3, 0.9 } },
		labelColor = { default = { 1, 1, 1 }, over = { 1, 1, 1 } }
		onRelease=function(event)
			composer.gotoScene("menu")
		end	


	}) 

return buttons
	