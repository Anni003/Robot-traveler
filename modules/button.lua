local widget = require("widget")

local M = {}

function M.newButton(label, key, x, y)
    local instance
    label = label or "D"
    key = key or "E"
    x = x or 0
    y = y or 0
    instance = widget.newButton({
        x = x,
        y = y,
        label = label,
        shape = "circle",
        radius = 20,
        cornerRadius = 5,
        fillColor = { default = { 0.11, 0.44, 0.72, 1.0 }, over = { 0.09, 0.36, 0.6, 1.0 } },
        labelColor = { default = { 1.0, 1.0, 1.0, 1.0 }, over = { 1.0, 1.0, 1.0, 1.0 } },
        strokeWidth = 3,
        strokeColor = { default = { 1.0, 1.0, 1.0, 1.0 }, over = { 1.0, 1.0, 1.0, 1.0 } },
        font = "scenes/platformer/font/geometria_bold.otf",
        fontSize = 20,
        onEvent = function(event)
            local phase = event.phase
            if phase == "began" then
                local keyEvent = { name = "key", phase = "down", keyName = key or "none" }
                Runtime:dispatchEvent(keyEvent)
            elseif phase == "ended" or phase == "cancelled" then
                local keyEvent = { name = "key", phase = "up", keyName = key or "none" }
                Runtime:dispatchEvent(keyEvent)
            end
            return true
        end
    })
    return instance
end

return M