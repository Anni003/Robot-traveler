local Block = {}

function Block:new(x, y)
    local data = {}
    setmetatable(data, { __index = Block })
    data.x = x
    data.y = y
    data.coordX = 0
    data.coordY = 0
    data.leftBorder = true
    data.topBorder = true
    data.visited = false
    data.distanceFromStart = 0
    return data
end

return Block