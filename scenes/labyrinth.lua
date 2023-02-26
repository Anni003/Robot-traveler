-- Include the modules/libraries
local composer = require("composer")
local Pointer = require("scenes.labyrinth.lib.pointer")
local Block = require("scenes.labyrinth.lib.block")
local Stack = require("scenes.labyrinth.lib.stack")

-- Local mutable variables
local width = 12 + 1
local height = 9 + 1
local blockSize = 100
local background = { 0.96, 0.96, 0.98 }
local blockBackground = { 0.59, 0.26, 0.33 }
local blockStrokeColor = { 0.56, 0.87, 0.36 }
local blockShadowColor = { 0.24, 0.64, 0.44 }
local controlButtonColor = { 0.93, 0.67, 0.29 }
local borderRadius = 10
local strokeWidth = blockSize / 5
local pointerRadius = strokeWidth

-- Local immutable variables
local labyrinth = {}
local labyrinthWidth = width - 1 == 1 and blockSize or width - 1 == 2 and blockSize * 2 - strokeWidth or (blockSize - strokeWidth / 2) * 2 + (blockSize - strokeWidth) * (width - 3)
local labyrinthHeight = height - 1 == 1 and blockSize or height - 1 == 2 and blockSize * 2 - strokeWidth or (blockSize - strokeWidth / 2) * 2 + (blockSize - strokeWidth) * (height - 3)
local labyrinthStartX = (display.contentWidth - labyrinthWidth) / 2
local labyrinthStartY = (display.contentHeight - labyrinthHeight) / 2
local pointer
local startBlock
local endBlock
local rightButton
local leftButton
local upButton
local bottomButton

local function getNeighbors(block)
    local neighbours = { right = false, left = false, up = false, bottom = false }
    if (block.x < width and not labyrinth[block.x + 1][block.y].leftBorder) then neighbours.right = true end
    if (block.x > 1 and not labyrinth[block.x][block.y].leftBorder) then neighbours.left = true end
    if (block.y < height and not labyrinth[block.x][block.y + 1].topBorder) then neighbours.bottom = true end
    if (block.y > 1 and not labyrinth[block.x][block.y].topBorder) then neighbours.up = true end
    return neighbours
end

local function getNeighborsExceptPrevious(previous, current)
    local neighbours = { right = false, left = false, up = false, bottom = false }
    if (current.x < width and labyrinth[current.x + 1][current.y] ~= previous and not labyrinth[current.x + 1][current.y].leftBorder) then neighbours.right = true end
    if (current.x > 1 and labyrinth[current.x - 1][current.y] ~= previous and not labyrinth[current.x][current.y].leftBorder) then neighbours.left = true end
    if (current.y < height and labyrinth[current.x][current.y + 1] ~= previous and not labyrinth[current.x][current.y + 1].topBorder) then neighbours.bottom = true end
    if (current.y > 1 and labyrinth[current.x][current.y - 1] ~= previous and not labyrinth[current.x][current.y].topBorder) then neighbours.up = true end
    return neighbours
end

local function getTrueNeighborsNumber(neighbours)
    local count = 0
    if (neighbours.right) then count = count + 1 end
    if (neighbours.left) then count = count + 1 end
    if (neighbours.up) then count = count + 1 end
    if (neighbours.bottom) then count = count + 1 end
    return count
end

local hideAllControlButtons = function()
    rightButton.isVisible = false
    leftButton.isVisible = false
    upButton.isVisible = false
    bottomButton.isVisible = false
end

local function controlSystem()
    local neighbours = getNeighbors(pointer.currentBlock)
    local block = pointer.currentBlock
    if (neighbours.right) then
        rightButton.x = labyrinth[block.x + 1][block.y].coordX - blockSize / 2 + strokeWidth / 2
        rightButton.y = labyrinth[block.x + 1][block.y].coordY
        rightButton.isVisible = true
    end
    if (neighbours.left) then
        leftButton.x = labyrinth[block.x - 1][block.y].coordX + blockSize / 2 - strokeWidth / 2
        leftButton.y = labyrinth[block.x - 1][block.y].coordY
        leftButton.isVisible = true
    end
    if (neighbours.up) then
        upButton.x = labyrinth[block.x][block.y - 1].coordX
        upButton.y = labyrinth[block.x][block.y - 1].coordY + blockSize / 2 - strokeWidth / 2
        upButton.isVisible = true
    end
    if (neighbours.bottom) then
        bottomButton.x = labyrinth[block.x][block.y + 1].coordX
        bottomButton.y = labyrinth[block.x][block.y + 1].coordY - blockSize / 2 + strokeWidth / 2
        bottomButton.isVisible = true
    end
end

local directionControl = function(direction)
    hideAllControlButtons()
    local block, neighbours, neighboursNumber, moveTime
    if direction == "right" then
        block = labyrinth[pointer.currentBlock.x + 1][pointer.currentBlock.y]
        neighbours = getNeighborsExceptPrevious(labyrinth[block.x - 1][block.y], block)
        neighboursNumber = getTrueNeighborsNumber(neighbours)
        while (neighboursNumber < 2 and not labyrinth[block.x + 1][block.y].leftBorder) do
            block = labyrinth[block.x + 1][block.y]
            neighbours = getNeighborsExceptPrevious(labyrinth[block.x - 1][block.y], block)
            neighboursNumber = getTrueNeighborsNumber(neighbours)
        end
    elseif direction == "left" then
        block = labyrinth[pointer.currentBlock.x - 1][pointer.currentBlock.y]
        neighbours = getNeighborsExceptPrevious(labyrinth[block.x + 1][block.y], block)
        neighboursNumber = getTrueNeighborsNumber(neighbours)
        while (neighboursNumber < 2 and not labyrinth[block.x][block.y].leftBorder) do
            block = labyrinth[block.x - 1][block.y]
            neighbours = getNeighborsExceptPrevious(labyrinth[block.x + 1][block.y], block)
            neighboursNumber = getTrueNeighborsNumber(neighbours)
        end
    elseif direction == "up" then
        block = labyrinth[pointer.currentBlock.x][pointer.currentBlock.y - 1]
        neighbours = getNeighborsExceptPrevious(labyrinth[block.x][block.y + 1], block)
        neighboursNumber = getTrueNeighborsNumber(neighbours)
        while (neighboursNumber < 2 and not labyrinth[block.x][block.y].topBorder) do
            block = labyrinth[block.x][block.y - 1]
            neighbours = getNeighborsExceptPrevious(labyrinth[block.x][block.y + 1], block)
            neighboursNumber = getTrueNeighborsNumber(neighbours)
        end
    elseif direction == "down" then
        block = labyrinth[pointer.currentBlock.x][pointer.currentBlock.y + 1]
        neighbours = getNeighborsExceptPrevious(labyrinth[block.x][block.y - 1], block)
        neighboursNumber = getTrueNeighborsNumber(neighbours)
        while (neighboursNumber < 2 and not labyrinth[block.x][block.y + 1].topBorder) do
            block = labyrinth[block.x][block.y + 1]
            neighbours = getNeighborsExceptPrevious(labyrinth[block.x][block.y - 1], block)
            neighboursNumber = getTrueNeighborsNumber(neighbours)
        end
    else
        error("Error: Wrong direction");
    end
    moveTime = pointer:move(labyrinth[block.x][block.y].coordX, labyrinth[block.x][block.y].coordY, labyrinth[block.x][block.y])
    if block ~= endBlock then
        timer.performWithDelay(moveTime, controlSystem)
    end
    if pointer.currentBlock == endBlock then
        timer.performWithDelay(moveTime, function()
            transition.to(pointer, { time = 500, alpha = 0, x = pointer.x - 10, y = pointer.y + 10, xScale = 0.1, yScale = 0.1 })
            timer.performWithDelay(500, function()
                composer.removeScene("scenes.labyrinth")
                composer.gotoScene("scenes.three_doors")
            end)
        end)
    end
end

local function rightButtonTap() directionControl("right") end
local function leftButtonTap() directionControl("left") end
local function upButtonTap() directionControl("up") end
local function bottomButtonTap() directionControl("down") end

local function key(event)
    local phase, keyName = event.phase, event.keyName
    if phase == "down" then
        if keyName == "left" or keyName == "a" then
            if (leftButton.isVisible) then directionControl("left") end
        end
        if keyName == "right" or keyName == "d" then
            if (rightButton.isVisible) then directionControl("right") end
        end
        if keyName == "up" or keyName == "w" then
            if (upButton.isVisible) then directionControl("up") end
        end
        if keyName == "down" or keyName == "s" then
            if (bottomButton.isVisible) then directionControl("down") end
        end
    end
end

-- Create a new Composer scene
local scene = composer.newScene()

-- This function is called when scene is created
function scene:create(event)
	local sceneGroup = self.view -- Group for adding scene display objects

    -- Create a rectangle
    local createRect = function(x, y, width, height, radius, color)
        local rect = display.newRoundedRect(sceneGroup, x, y, width, height, radius)
        rect:setFillColor(unpack(color))
    end

    -- Generates a labyrinth matrix
    local createLabyrinth = function()
        for x = 1, width do
            labyrinth[x] = {}
            for y = 1, height do
                labyrinth[x][y] = Block:new(x, y)
                labyrinth[x][y].coordX = blockSize * (labyrinth[x][y].x - 0.5) - strokeWidth * (labyrinth[x][y].x - 1) + labyrinthStartX
                labyrinth[x][y].coordY = blockSize * (labyrinth[x][y].y - 0.5) - strokeWidth * (labyrinth[x][y].y - 1) + labyrinthStartY
            end
        end
        startBlock = labyrinth[math.random(width - 1)][math.random(height - 1)]
    end

    -- Generates a random labyrinth path
    local generatePaths = function()
        local current = startBlock
        local stack = Stack
        current.visited = true
        while current ~= nil do
            local unvisitedNeighbours = {}
            local x = current.x
            local y = current.y
            if x > 1 and not labyrinth[x - 1][y].visited then table.insert(unvisitedNeighbours, labyrinth[x - 1][y]) end
            if y > 1 and not labyrinth[x][y - 1].visited then table.insert(unvisitedNeighbours, labyrinth[x][y - 1]) end
            if x < width - 1 and not labyrinth[x + 1][y].visited then table.insert(unvisitedNeighbours, labyrinth[x + 1][y]) end
            if y < height - 1 and not labyrinth[x][y + 1].visited then table.insert(unvisitedNeighbours, labyrinth[x][y + 1]) end
            if #unvisitedNeighbours ~= 0 then
                local chosen = unvisitedNeighbours[math.random(#unvisitedNeighbours)]
                if (current.x == chosen.x) then
                    if (current.y > chosen.y) then
                        current.topBorder = false
                    else
                        chosen.topBorder = false
                    end
                else
                    if (current.x > chosen.x) then
                        current.leftBorder = false
                    else
                        chosen.leftBorder = false
                    end
                end
                chosen.visited = true
                stack.push(chosen)
                chosen.distanceFromStart = current.distanceFromStart + 1
                current = chosen
            else
                current = stack.pop()
            end
        end
    end

    -- Creates an endpoint
    local addExit = function()
        local furthest = startBlock
		for x = 1, width - 1 do
			for y = 1, height - 1 do
				if labyrinth[x][y].distanceFromStart > furthest.distanceFromStart then furthest = labyrinth[x][y] end
			end
		end
        endBlock = furthest
        createRect(endBlock.coordX, endBlock.coordY, pointerRadius * 2, pointerRadius * 2, 50, { 0.34, 0.16, 0.29 })
        createRect(endBlock.coordX - 2, endBlock.coordY + 2, pointerRadius * 2, pointerRadius * 2, 50, { 0.24, 0.14, 0.28 })
    end

    -- Draws a labyrinth on the screen
    local drawBorders = function()
        -- Draws the background of the blocks
        for x = 1, width do
            for y = 1, height do
                local block = labyrinth[x][y]
                if y < height and x < width then
                    createRect(block.coordX, block.coordY, blockSize, blockSize, borderRadius, blockBackground)
                end
            end
        end
        -- Draws a shadow from the borders of the block
        for x = 1, width do
            for y = 1, height do
                local block = labyrinth[x][y]
                if block.leftBorder and y < height then
                    createRect(block.coordX - blockSize / 2 + strokeWidth / 2 - 2, block.coordY + 2, strokeWidth, blockSize, borderRadius, blockShadowColor)
                end
                if block.topBorder and x < width then
                    createRect(block.coordX - 2, block.coordY - blockSize / 2 + strokeWidth / 2 + 2, blockSize, strokeWidth, borderRadius, blockShadowColor)
                end
            end
        end
        -- Draws block borders
        for x = 1, width do
            for y = 1, height do
                local block = labyrinth[x][y]
                if block.leftBorder and y < height then
                    createRect(block.coordX - blockSize / 2 + strokeWidth / 2, block.coordY, strokeWidth, blockSize, borderRadius, blockStrokeColor)
                end
                if block.topBorder and x < width then
                    createRect(block.coordX, block.coordY - blockSize / 2 + strokeWidth / 2, blockSize, strokeWidth, borderRadius, blockStrokeColor)
                end
            end
        end
    end

	-- Adding background
	display.setDefault("background", unpack(background))

    -- Creating and drawing a labyrinth
    createLabyrinth()
    generatePaths()
    drawBorders()
    addExit()

    -- Create pointer
    pointer = Pointer:new(startBlock.coordX, startBlock.coordY, startBlock, pointerRadius)

    -- Creating control buttons
    rightButton = display.newImageRect("scenes/labyrinth/img/arrow.png", pointerRadius, pointerRadius)
    leftButton = display.newImageRect("scenes/labyrinth/img/arrow.png", pointerRadius, pointerRadius)
    upButton = display.newImageRect("scenes/labyrinth/img/arrow.png", pointerRadius, pointerRadius)
    bottomButton = display.newImageRect("scenes/labyrinth/img/arrow.png", pointerRadius, pointerRadius)
    leftButton.rotation = 180
    upButton.rotation = 270
    bottomButton.rotation = 90
    rightButton:setFillColor(unpack(controlButtonColor))
    leftButton:setFillColor(unpack(controlButtonColor))
    upButton:setFillColor(unpack(controlButtonColor))
    bottomButton:setFillColor(unpack(controlButtonColor))

    hideAllControlButtons()
    controlSystem()

    sceneGroup:insert(pointer)
    sceneGroup:insert(rightButton)
    sceneGroup:insert(leftButton)
    sceneGroup:insert(upButton)
    sceneGroup:insert(bottomButton)
end

-- This function is called when scene comes fully on screen
function scene:show(event)
	local phase = event.phase
	if (phase == "will") then

	elseif (phase == "did") then
        rightButton:addEventListener("tap", rightButtonTap)
        leftButton:addEventListener("tap", leftButtonTap)
        upButton:addEventListener("tap", upButtonTap)
        bottomButton:addEventListener("tap", bottomButtonTap)
        Runtime:addEventListener("key", key)
	end
end

-- This function is called when scene goes fully off screen
function scene:hide(event)
	local phase = event.phase
	if (phase == "will") then
        rightButton:removeEventListener("tap", rightButtonTap)
        leftButton:removeEventListener("tap", leftButtonTap)
        upButton:removeEventListener("tap", upButtonTap)
        bottomButton:removeEventListener("tap", bottomButtonTap)
        Runtime:removeEventListener("key", key)
	elseif (phase == "did") then

	end
end

-- This function is called when scene is destroyed
function scene:destroy(event)

end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

return scene
