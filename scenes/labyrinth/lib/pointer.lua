local Pointer = {}

function Pointer.new(instance, x, y, startBlock, radius)
	local x, y = x, y
    instance = display.newGroup()
    instance.x, instance.y = x, y
    instance.shadow = display.newCircle(instance, -2, 2, radius)
    instance.shadow:setFillColor(unpack({ 0.34, 0.16, 0.29 }))
    instance.body = display.newCircle(instance, 0, 0, radius)
    instance.body:setFillColor(unpack({ 0.89, 0.41, 0.34 }))
	instance.currentBlock = startBlock
    function instance:move(x, y, block)
        local moveTime = (math.abs(instance.currentBlock.x - block.x) + math.abs(instance.currentBlock.y - block.y)) * 150
        transition.moveTo(instance, { x = x, y = y, time = moveTime })
        instance.currentBlock = block
        return moveTime
    end
    return instance
end

return Pointer