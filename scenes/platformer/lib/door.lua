local composer = require("composer")

local M = {}

function M.new(instance)
	if not instance.bodyType then
		physics.addBody(instance, "static")
	end

	function instance:collision(event)
		local phase, other = event.phase, event.other
		if phase == "began" and other.name == "hero" then
			other:finalize()
			composer.gotoScene(self.map)
		end
	end

    instance:addEventListener("collision")

    instance.name = "door"
	instance.type = "door"
    return instance
end

return M
