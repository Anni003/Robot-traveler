local composer = require("composer")

local M = {}

function M.new(instance, x, y, startCell)
	local x, y = x, y
	instance = display.newCircle(x, y, 8)
	instance.currentCell = startCell

	function instance:update(x, y, currentCell)
		transition.to(instance, { x = x, y = y, time = 100 })
		instance.currentCell = currentCell
	end

    return instance
end

return M
