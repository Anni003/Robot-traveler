local composer = require("composer")
local custom = require("modules.button")

local M = {}

function M.new(instance)
	local scene = composer.getScene(composer.getSceneName("current"))
	local sounds = scene.sounds

	local button, text

	local isMobile = ("ios" == system.getInfo("platform")) or ("android" == system.getInfo("platform"))

	button = custom.newButton("E", "e", display.contentWidth - 40, display.contentHeight - 130)
	text = display.newText("Для входа нажмите E", 0, 0, "scenes/platformer/font/geometria_bold.otf", 12)

	local function showButton()
		button.isVisible = true
	end

	local function hideButton()
		button.isVisible = false
	end

	local function showText(content)
		text.text = content
		text.x = display.contentWidth / 2
		text.y = 40
		text.isVisible = true
	end

	local function hideText()
		text.isVisible = false
	end

	hideButton()
	hideText()

	local function action(event)
		local phase, keyName = event.phase, event.keyName
		if phase == "down" and keyName == "e" then
			if zvukGlobal then
				audio.play(sounds.door, { channel = 2 })
			end
			Runtime:removeEventListener("key", action)
			hideButton()
			hideText()
			composer.gotoScene("hidden_object")
		end
	end

	function instance:collision(event)
		local phase, other = event.phase, event.other
		if phase == "began" and other.name == "hero" then
			if not self.isClosed then
				Runtime:addEventListener("key", action)
				showText("Для входа нажмите E")
				if isMobile then
					showButton()
				end
			else
				showText("Дверь закрыта")
			end
		end
		if phase == "ended" and other.name == "hero" then
			Runtime:removeEventListener("key", action)
			hideButton()
			hideText()
		end
	end

    instance:addEventListener("collision")

    instance.name = "door"
	instance.type = "door"
    return instance
end

return M
