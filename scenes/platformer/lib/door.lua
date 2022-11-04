local composer = require("composer")

local M = {}

function M.new(instance)
	if not instance.bodyType then
		physics.addBody(instance, "static")
		instance.isSensor = true
	end

	local text
	local text2

	local function key(event)
		local phase, keyName = event.phase, event.keyName
		if phase == "down" then
			if keyName == "e" then
				Runtime:removeEventListener("key", key)
				display.remove(text)
				composer.gotoScene("hidden_object")
			end
		end
	end

	function instance:collision(event)
		local phase, other = event.phase, event.other
		if phase == "began" and other.name == "hero" then
			if not self.isClosed then
				Runtime:addEventListener("key", key)
				local x, y = instance:localToContent(0, 0)
				text = display.newText("Для входа нажмите E", x, y - 30, native.systemFont, 10)
			else
				local x, y = instance:localToContent(0, 0)
				text2 = display.newText("Дверь закрыта", x, y - 30, native.systemFont, 10)
			end
		end
		if phase == "ended" and other.name == "hero" then
			if not self.isClosed then
				Runtime:removeEventListener("key", key)
				display.remove(text)
			else
				display.remove(text2)
			end
		end
	end

    instance:addEventListener("collision")

    instance.name = "door"
	instance.type = "door"
    return instance
end

return M
