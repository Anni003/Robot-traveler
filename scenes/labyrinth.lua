-- Include the modules/libraries
local composer = require("composer")
local Pointer = require("scenes.labyrinth.lib.pointer")
local Block = require("scenes.labyrinth.lib.block")
local Stack = require("scenes.labyrinth.lib.stack")
local widget = require("scenes.labyrinth.lib.button")

-- Local variables
local labyrinth = {}
local width = 17 + 1
local height = 17 + 1
local pitSize = 4
local blockBackground = { 1, 1, 1 }
local blockStrokeColor = { 0, 0, 0 }
local controlButtonColor = { 0.93, 0.67, 0.29 }
local blockSize = 34
local strokeWidth = blockSize / 8
local pointerRadius = strokeWidth * 8 / 5
local borderRadius = 0
local labyrinthWidth = width - 1 == 1 and blockSize or width - 1 == 2 and blockSize * 2 - strokeWidth or (blockSize - strokeWidth / 2) * 2 + (blockSize - strokeWidth) * (width - 3)
local labyrinthHeight = height - 1 == 1 and blockSize or height - 1 == 2 and blockSize * 2 - strokeWidth or (blockSize - strokeWidth / 2) * 2 + (blockSize - strokeWidth) * (height - 3)
local labyrinthStartX = (display.contentWidth - labyrinthWidth) / 2 + display.contentWidth * 0.140625
local labyrinthStartY = (display.contentHeight - labyrinthHeight) / 2 - 3
local controlButtonXOffset = blockSize
local controlButtonYOffset = - blockSize
local pointer, startBlock, endBlock, rightButton, leftButton, upButton, bottomButton

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
    rightButton.alpha = 0.2
    leftButton.alpha = 0.2
    upButton.alpha = 0.2
    bottomButton.alpha = 0.2
    rightButton.isActive = false
    leftButton.isActive = false
    upButton.isActive = false
    bottomButton.isActive = false
end

local function controlSystem()
    local neighbours = getNeighbors(pointer.currentBlock)
    local block = pointer.currentBlock
    if (neighbours.right) then
        rightButton.alpha = 1
        rightButton.isActive = true
    end
    if (neighbours.left) then
        leftButton.alpha = 1
        leftButton.isActive = true
    end
    if (neighbours.up) then
        upButton.alpha = 1
        upButton.isActive = true
    end
    if (neighbours.bottom) then
        bottomButton.alpha = 1
        bottomButton.isActive = true
    end
end

directionControl = function(direction)
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
            transition.to(pointer, { time = 980, x = labyrinthStartX + labyrinthWidth / 2, y = labyrinthStartY + labyrinthHeight / 2, xScale = display.actualContentWidth, yScale = display.actualContentWidth })
            rightButton.isVisible = false
            leftButton.isVisible = false
            upButton.isVisible = false
            bottomButton.isVisible = false
            timer.performWithDelay(1000, function()
                composer.removeScene("scenes.labyrinth")
                composer.gotoScene("menu")
            end)
        end)
    end
end

local function key(event)
    local phase, keyName = event.phase, event.keyName
    if phase == "down" then
        if keyName == "left" or keyName == "a" then
            if (leftButton.isActive) then directionControl("left") end
        end
        if keyName == "right" or keyName == "d" then
            if (rightButton.isActive) then directionControl("right") end
        end
        if keyName == "up" or keyName == "w" then
            if (upButton.isActive) then directionControl("up") end
        end
        if keyName == "down" or keyName == "s" then
            if (bottomButton.isActive) then directionControl("down") end
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
                if ((y > height - 1 - pitSize and x < pitSize + 1) or (x > width - 1 - pitSize and y < pitSize + 1)) then
                    labyrinth[x][y].visited = true
                end
            end
        end
    end

    -- Generates a random labyrinth path
    local generatePaths = function()
        -- Generate start block
        local rand = math.random(2)
		if rand == 2 then
			startBlock = labyrinth[math.random(pitSize)][height - 1 - pitSize]
		else
			startBlock = labyrinth[pitSize + 1][height - math.random(pitSize)]
		end

        -- Generate inactive side parts
		for i = 1, pitSize do
			for k = 1, pitSize do
				labyrinth[k][height + 1 - i].topBorder = false
				labyrinth[width - k][i].topBorder = false
                labyrinth[i][height - k].leftBorder = false
				labyrinth[width + 1 - i][k].leftBorder = false
			end
		end

        local current = startBlock
        local stack = Stack
        current.visited = true
        current.distanceFromStart = 0
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
    local function addExit()
        endBlock = startBlock
		for x = 1, width - 1 do
			for y = 1, height - 1 do
				if (y == pitSize + 1 and x > width - 1 - pitSize) or (x == width - 1 - pitSize and y < pitSize + 1) then
					if labyrinth[x][y].distanceFromStart > endBlock.distanceFromStart then endBlock = labyrinth[x][y] end
				end
			end
		end
		if endBlock.distanceFromStart < (height * width - pitSize * pitSize * 2) / 1.8 then
            createLabyrinth()
			generatePaths()
			addExit()
            return
		end
		if endBlock.y == pitSize + 1 then
			endBlock.topBorder = false
			endBlock = labyrinth[endBlock.x][endBlock.y - 1]
		else
			labyrinth[endBlock.x + 1][endBlock.y].leftBorder = false
			endBlock = labyrinth[endBlock.x + 1][endBlock.y]
		end
    end

    -- Draws blocks on the screen
    local drawBlocks = function()
        -- Draws the background of the blocks on the screen
        for x = 1, width do
            for y = 1, height do
                local block = labyrinth[x][y]
                if y < height and x < width then
                    if not ((y > height - 1 - pitSize and x < pitSize + 1) or (x > width - 1 - pitSize and y < pitSize + 1)) then
                        createRect(block.coordX, block.coordY, blockSize, blockSize, borderRadius, blockBackground)
                    end
                end
            end
        end
        -- Draws borders on the screen
        for x = 1, width do
            for y = 1, height do
                local block = labyrinth[x][y]
                if block.leftBorder and y < height then
                    if not (block.x == pitSize + 1 and block == startBlock) then
                        createRect(block.coordX - blockSize / 2 + strokeWidth / 2, block.coordY, strokeWidth, blockSize, borderRadius, blockStrokeColor)
                    end
                end
                if block.topBorder and x < width then
                    if not (block.y == height - pitSize and labyrinth[block.x][block.y - 1] == startBlock) then
                        createRect(block.coordX, block.coordY - blockSize / 2 + strokeWidth / 2, blockSize, strokeWidth, borderRadius, blockStrokeColor)
                    end
                end
            end
        end
    end

	-- Adding background
    local background = display.newImageRect("scenes/labyrinth/img/background.png", display.actualContentWidth, display.actualContentHeight)
	background.x, background.y = display.contentWidth / 2, display.contentHeight / 2
    sceneGroup:insert(background)
	local background1 = display.newImageRect("scenes/labyrinth/img/elements.png", display.contentWidth, display.contentHeight)
	background1.x, background1.y = display.contentWidth / 2, display.contentHeight / 2
    sceneGroup:insert(background1)
    local back1 = display.newImageRect("scenes/labyrinth/img/background.png", 2, display.contentHeight)
	back1.x, back1.y = 0, display.contentHeight / 2
    sceneGroup:insert(back1)
    local back2 = display.newImageRect("scenes/labyrinth/img/background.png", 2, display.contentHeight)
	back2.x, back2.y = display.contentWidth, display.contentHeight / 2
    sceneGroup:insert(back2)

    -- Creating and drawing a labyrinth
    createLabyrinth()
    generatePaths()
    addExit()
    drawBlocks()

    -- Create pointer
    pointer = Pointer:new(startBlock.coordX, startBlock.coordY, startBlock, pointerRadius)

    -- Creating control buttons
    rightButton = widget.newButton("→", blockSize, "d", blockSize * 2, blockSize * 8 + controlButtonXOffset, display.contentHeight - blockSize * 5 + controlButtonYOffset, "right")
    leftButton = widget.newButton("←", blockSize, "a", blockSize * 2, blockSize * 2 + controlButtonXOffset, display.contentHeight - blockSize * 5 + controlButtonYOffset, "left")
    upButton = widget.newButton("↑", blockSize, "w", blockSize * 2, blockSize * 5 + controlButtonXOffset, display.contentHeight - blockSize * 8 + controlButtonYOffset, "up")
    bottomButton = widget.newButton("↓", blockSize, "s", blockSize * 2, blockSize * 5 + controlButtonXOffset, display.contentHeight - blockSize * 2 + controlButtonYOffset, "down")


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
        -- rightButton:addEventListener("tap", rightButtonTap)
        -- leftButton:addEventListener("tap", leftButtonTap)
        -- upButton:addEventListener("tap", upButtonTap)
        -- bottomButton:addEventListener("tap", bottomButtonTap)
        Runtime:addEventListener("key", key)
	end
end

-- This function is called when scene goes fully off screen
function scene:hide(event)
	local phase = event.phase
	if (phase == "will") then
        -- rightButton:removeEventListener("tap", rightButtonTap)
        -- leftButton:removeEventListener("tap", leftButtonTap)
        -- upButton:removeEventListener("tap", upButtonTap)
        -- bottomButton:removeEventListener("tap", bottomButtonTap)
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
