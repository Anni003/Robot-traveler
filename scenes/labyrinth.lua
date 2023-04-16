local composer = require("composer")
local widget = require("widget")

-- Variables
local grid
local width = 15
local height = 15
local cellSideSize = 38
local borderWidth = cellSideSize / 10
local labyrinthWidth = width * cellSideSize - (width - 1) * borderWidth
local labyrinthHeight = height * cellSideSize - (height - 1) * borderWidth
local labyrinthStartX = (display.contentWidth - labyrinthWidth) / 2 + display.contentWidth * 0.140625
local labyrinthStartY = (display.contentHeight - labyrinthHeight) / 2 - 3
local numberEmptyCells = 4
local borderRadius = 0
local cellColor = { 1, 1, 1 }
local borderColor = { 0, 0, 0 }
local pointerRadius = cellSideSize / 6
local controlButtonSize = pointerRadius / 0.8
local gridGroup = display.newGroup()
local controlButtonsGroup = display.newGroup()
local scoreTimer
local startCell
local endCell
local pointer
local controlButtons = {
    north = display.newImageRect(controlButtonsGroup, "scenes/labyrinth/images/arrow.png", controlButtonSize, controlButtonSize),
    south = display.newImageRect(controlButtonsGroup, "scenes/labyrinth/images/arrow.png", controlButtonSize, controlButtonSize),
    west = display.newImageRect(controlButtonsGroup, "scenes/labyrinth/images/arrow.png", controlButtonSize, controlButtonSize),
    east = display.newImageRect(controlButtonsGroup, "scenes/labyrinth/images/arrow.png", controlButtonSize, controlButtonSize),
}
controlButtons.north:setFillColor(unpack({ 0.63, 0.53, 0.99 }))
controlButtons.south:setFillColor(unpack({ 0.63, 0.53, 0.99 }))
controlButtons.west:setFillColor(unpack({ 0.63, 0.53, 0.99 }))
controlButtons.east:setFillColor(unpack({ 0.63, 0.53, 0.99 }))
controlButtons.south:rotate(90)
controlButtons.west:rotate(180)
controlButtons.north:rotate(270)

-- Classes
local Cell = {}

function Cell:new(col, row)
    local self = setmetatable({}, Cell)
    self.col = col or 1
    self.row = row or 1
    self.x = self.col * (cellSideSize - borderWidth) - cellSideSize / 2 + borderWidth + labyrinthStartX
    self.y = self.row * (cellSideSize - borderWidth) - cellSideSize / 2 + borderWidth + labyrinthStartY
    self.walls = {
        north = { x = self.x, y = self.y - cellSideSize / 2 + borderWidth / 2 },
        south = { x = self.x, y = self.y + cellSideSize / 2 - borderWidth / 2 },
        west = { x = self.x - cellSideSize / 2 + borderWidth / 2, y = self.y },
        east = { x = self.x + cellSideSize / 2 - borderWidth / 2, y = self.y },
    }
    self.neighbours = {}
    self.numberNeighbours = 0
    self.visited = false
    self.distance = 0
    return self
end

local Pointer = {}

function Pointer.new(instance, size, block)
    instance = display.newGroup()
    instance.block = block or startCell
    instance.prevBlock = nil
    instance.x, instance.y = instance.block.x, instance.block.y
    instance.circle = display.newImageRect(instance, "scenes/labyrinth/images/circle.png", size, size)
    instance.circle:setFillColor(unpack({ 0.63, 0.53, 0.99 }))
    function instance:move(current, previous)
        local time = (math.abs(instance.block.col - current.col) + math.abs(instance.block.row - current.row)) * 150
        transition.moveTo(instance, { x = current.x, y = current.y, time = time })
        instance.prevBlock = previous
        instance.block = current
        return time
    end
    return instance
end

local Timer = {}

function Timer.new(instance, x, y)
	instance.score = 0
    instance.text = display.newText(instance.score, x, y, "scenes/labyrinth/font/geometria_bold", 36)

    function instance:getScore()
        return instance.score
    end

    local function increaseScore(event)
		instance.score = event.count
        instance.text.text = instance.score
	end

    function instance:start()
        timer.performWithDelay(1000, increaseScore, 0, "timer")
    end

    function instance:pause()
        timer.pause("timer")
    end

    function instance:resume()
        timer.resume("timer")
    end

    function instance:cancel()
        timer.cancel("timer")
    end

    function instance:delete()
        display.remove(instance.text)
    end

    return instance
end

-- Functions
local function drawCell(x, y, size)
    local cell = display.newRoundedRect(gridGroup, x, y, size, size, borderRadius)
    cell:setFillColor(unpack(cellColor))
end

local function drawBorder(x, y, width, height)
    local border = display.newRoundedRect(gridGroup, x, y, width, height, borderRadius)
    border:setFillColor(unpack(borderColor))
end

local function createEmptyGrid()
    grid = {}
    for col = 1, width do
        grid[col] = {}
        for row = 1, height do
            if ((row > height - numberEmptyCells and col <= numberEmptyCells) or (col > width - numberEmptyCells and row <= numberEmptyCells)) then
                grid[col][row] = nil
            else
                grid[col][row] = Cell:new(col, row)
            end
        end
    end
end

local function generateStartCell()
    local random = math.random(2)
	if (random == 2) then
		startCell = grid[math.random(numberEmptyCells)][height - numberEmptyCells]
        startCell.walls.south = nil
	else
		startCell = grid[numberEmptyCells + 1][height - math.random(numberEmptyCells) + 1]
        startCell.walls.west = nil
	end
end

local function generatePaths()
    local current = startCell
    local stack = {}
    current.visited = true
    while current ~= nil do
        local directions = {}
        local col, row = current.col, current.row
        if col > 1 and grid[col - 1][row] and not grid[col - 1][row].visited then table.insert(directions, grid[col - 1][row]) end
        if row > 1 and grid[col][row - 1] and not grid[col][row - 1].visited then table.insert(directions, grid[col][row - 1]) end
        if col < width and grid[col + 1][row] and not grid[col + 1][row].visited then table.insert(directions, grid[col + 1][row]) end
        if row < height and grid[col][row + 1] and not grid[col][row + 1].visited then table.insert(directions, grid[col][row + 1]) end
        if #directions ~= 0 then
            local chosen = directions[math.random(#directions)]
            if (current.col == chosen.col) then
                if (current.row > chosen.row) then
                    current.walls.north = nil
                    current.neighbours.north = chosen
                    chosen.walls.south = nil
                    chosen.neighbours.south = current
                else
                    current.walls.south = nil
                    current.neighbours.south = chosen
                    chosen.walls.north = nil
                    chosen.neighbours.north = current
                end
            else
                if (current.col > chosen.col) then
                    current.walls.west = nil
                    current.neighbours.west = chosen
                    chosen.walls.east = nil
                    chosen.neighbours.east = current
                else
                    current.walls.east = nil
                    current.neighbours.east = chosen
                    chosen.walls.west = nil
                    chosen.neighbours.west = current
                end
            end
            current.numberNeighbours = current.numberNeighbours + 1
            chosen.numberNeighbours = chosen.numberNeighbours + 1
            chosen.visited = true
            table.insert(stack, chosen)
            chosen.distance = current.distance + 1
            current = chosen
        else
            current = table.remove(stack)
        end
    end
end

local function generateEndCell()
    endCell = startCell
    for col = 1, width do
        for row = 1, height do
            if ((row == numberEmptyCells + 1 and col > width - numberEmptyCells) or (col == width - numberEmptyCells and row < numberEmptyCells + 1)) then
                if (grid[col][row].distance > endCell.distance) then endCell = grid[col][row] end
            end
        end
    end
    if endCell.distance < (height * width - numberEmptyCells * numberEmptyCells * 2) / 1.6 then
        createEmptyGrid()
        generateStartCell()
        generatePaths()
        generateEndCell()
        return
    end
    local newEndCell
    if (endCell.row == numberEmptyCells + 1) then
        endCell.walls.north = nil
        grid[endCell.col][endCell.row - 1] = Cell:new(endCell.col, endCell.row - 1)
        newEndCell = grid[endCell.col][endCell.row - 1]
        endCell.neighbours.north = newEndCell
        newEndCell.neighbours.south = endCell
    else
        endCell.walls.east = nil
        grid[endCell.col + 1][endCell.row] = Cell:new(endCell.col + 1, endCell.row)
        newEndCell = grid[endCell.col + 1][endCell.row]
        endCell.neighbours.east = newEndCell
        newEndCell.neighbours.west = endCell
    end
    newEndCell.numberNeighbours = newEndCell.numberNeighbours + 1
    endCell.numberNeighbours = endCell.numberNeighbours + 1
    newEndCell.walls = { north = nil, south = nil, west = nil, east = nil }
    newEndCell.distance = endCell.distance + 1
    endCell = newEndCell
end

local function drawGrid()
    for col = 1, width do
        for row = 1, height do
            local cell = grid[col][row]
            if (cell and not (cell == endCell)) then
                drawCell(cell.x, cell.y, cellSideSize)
            end
        end
    end
    for col = 1, width do
        for row = 1, height do
            local cell = grid[col][row]
            if (cell) then
                if (cell.walls.west) then
                    drawBorder(cell.walls.west.x, cell.walls.west.y, borderWidth, cellSideSize)
                end
                if (cell.walls.east) then
                    drawBorder(cell.walls.east.x, cell.walls.east.y, borderWidth, cellSideSize)
                end
                if (cell.walls.north) then
                    drawBorder(cell.walls.north.x, cell.walls.north.y, cellSideSize, borderWidth)
                end
                if (cell.walls.south) then
                    drawBorder(cell.walls.south.x, cell.walls.south.y, cellSideSize, borderWidth)
                end
            end
        end
    end
end

local function hideAllControlButtons()
    controlButtons.north.isVisible = false
    controlButtons.south.isVisible = false
    controlButtons.west.isVisible = false
    controlButtons.east.isVisible = false
end

local function controlSystem()
    local block = pointer.block
    if (block.neighbours.north) then
        controlButtons.north.x = block.x
        controlButtons.north.y = block.y - (cellSideSize - pointerRadius * 2) / 2
        controlButtons.north.isVisible = true
    end
    if (block.neighbours.south) then
        controlButtons.south.x = block.x
        controlButtons.south.y = block.y + (cellSideSize - pointerRadius * 2) / 2
        controlButtons.south.isVisible = true
    end
    if (block.neighbours.west) then
        controlButtons.west.x = block.x - (cellSideSize - pointerRadius * 2) / 2
        controlButtons.west.y = block.y
        controlButtons.west.isVisible = true
    end
    if (block.neighbours.east) then
        controlButtons.east.x = block.x + (cellSideSize - pointerRadius * 2) / 2
        controlButtons.east.y = block.y
        controlButtons.east.isVisible = true
    end
end

local function movementSystem(direction)
    hideAllControlButtons()
    local oppositeDirections = { north = "south", south = "north", west = "east", east = "west" }
    local current = pointer.block.neighbours[direction]
    while (current.numberNeighbours < 3 and current.neighbours[direction]) do
        current = current.neighbours[direction]
    end
    local time = pointer:move(current, current.neighbours[oppositeDirections[direction]])
    timer.performWithDelay(time, function()
        if (pointer.block == endCell) then
            transition.to(pointer, { time = 100, alpha = 0, transition = easing.inSine })
            scoreTimer:pause()
            local score = scoreTimer:getScore()
            local modal = display.newRoundedRect(gridGroup, display.contentWidth / 2, display.contentHeight / 2, 1, 1, 16)
            modal.alpha = 0.0
            modal:setFillColor(unpack({ 0.21, 0.42, 0.84 }))
            modal:setStrokeColor(unpack({ 0.13, 0.16, 0.32 }))
            modal.strokeWidth = 5
            local text1 = display.newText(gridGroup, "Поздравляю!", display.contentWidth / 2, modal.y - 100, "scenes/labyrinth/font/geometria_bold", 46)
            local text2 = display.newText(gridGroup, "Вы прошли лабиринт за " .. score .. " сек", display.contentWidth / 2, modal.y - 40, "scenes/labyrinth/font/geometria_bold", 36)
            local modalButton = widget.newButton({
                x = display.contentWidth / 2,
                y = modal.y + 80,
                label = "В меню",
                width = display.contentWidth / 2,
                height = 80,
                shape = "roundedRect",
                cornerRadius = 12,
                fillColor = { default = { 0.11, 0.44, 0.72, 1.0 }, over = { 0.09, 0.36, 0.6, 1.0 } },
                labelColor = { default = { 1.0, 1.0, 1.0, 1.0 }, over = { 1.0, 1.0, 1.0, 1.0 } },
                strokeWidth = 3,
                strokeColor = { default = { 1.0, 1.0, 1.0, 1.0 }, over = { 1.0, 1.0, 1.0, 1.0 } },
                font = "scenes/labyrinth/font/geometria_bold.otf",
                fontSize = 36,
                onEvent = function(event)
                    local phase = event.phase
                    if (phase == "ended") then
                        composer.removeScene("scenes.labyrinth")
                        composer.gotoScene("scenes.three_doors")
                    end
                end
            })
            text1.alpha = 0.0
            text2.alpha = 0.0
            modalButton.alpha = 0.0
            gridGroup:insert(modalButton)
            transition.to(modal, { time = 350, width = display.contentWidth - 80, height = 320, alpha = 1, transition = easing.inSine })
            transition.to(text1, { time = 600, alpha = 1, transition = easing.inSine })
            transition.to(text2, { time = 600, alpha = 1, transition = easing.inSine })
            transition.to(modalButton, { time = 600, alpha = 1, transition = easing.inSine })
            scoreTimer:delete()
            return
        end
        if (pointer.block.numberNeighbours >= 3 or pointer.block.numberNeighbours == 1) then
            controlSystem()
            return
        end
        for key in pairs(pointer.block.neighbours) do
            if (pointer.block.neighbours[key] ~= pointer.prevBlock) then
                movementSystem(key)
                break
            end
        end
    end)
end

local function key(event)
    local phase, keyName = event.phase, event.keyName
    if (phase == "down") then
        if ((keyName == "left" or keyName == "a") and controlButtons.west.isVisible) then movementSystem("west") end
        if ((keyName == "right" or keyName == "d") and controlButtons.east.isVisible) then movementSystem("east") end
        if ((keyName == "up" or keyName == "w") and controlButtons.north.isVisible) then movementSystem("north") end
        if ((keyName == "down" or keyName == "s") and controlButtons.south.isVisible) then movementSystem("south") end
    end
end

local function northButtonTap() movementSystem("north") end
local function southButtonTap() movementSystem("south") end
local function westButtonTap() movementSystem("west") end
local function eastButtonTap() movementSystem("east") end

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect("scenes/labyrinth/images/background.png", display.actualContentWidth, display.actualContentHeight)
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2
    sceneGroup:insert(background)
	local background1 = display.newImageRect("scenes/labyrinth/images/elements.png", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentWidth / 2, display.contentHeight / 2
    sceneGroup:insert(background1)
    local back1 = display.newImageRect("scenes/labyrinth/images/background.png", 2, display.contentHeight)
	back1.x, back1.y = 0, display.contentHeight / 2
    sceneGroup:insert(back1)
    local back2 = display.newImageRect("scenes/labyrinth/images/background.png", 2, display.contentHeight)
	back2.x, back2.y = display.contentWidth, display.contentHeight / 2
    sceneGroup:insert(back2)

    createEmptyGrid()
    generateStartCell()
    generatePaths()
    generateEndCell()
    drawGrid()

    pointer = Pointer:new(pointerRadius * 2)

    hideAllControlButtons()
    controlSystem()

    scoreTimer = Timer:new(display.contentWidth / 2, 40)
    scoreTimer:start()

    sceneGroup:insert(gridGroup)
    sceneGroup:insert(pointer)
    sceneGroup:insert(controlButtonsGroup)
end

function scene:show(event)
    local phase = event.phase
    if (phase == "will") then

    elseif (phase == "did") then
        controlButtons.north:addEventListener("tap", northButtonTap)
        controlButtons.south:addEventListener("tap", southButtonTap)
        controlButtons.west:addEventListener("tap", westButtonTap)
        controlButtons.east:addEventListener("tap", eastButtonTap)
        Runtime:addEventListener("key", key)
    end
end

function scene:hide(event)
    local phase = event.phase
    if (phase == "will") then
        controlButtons.north:removeEventListener("tap", northButtonTap)
        controlButtons.south:removeEventListener("tap", southButtonTap)
        controlButtons.west:removeEventListener("tap", westButtonTap)
        controlButtons.east:removeEventListener("tap", eastButtonTap)
        Runtime:removeEventListener("key", key)
    elseif (phase == "did") then

    end
end

function scene:destroy(event)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
