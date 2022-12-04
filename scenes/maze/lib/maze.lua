-- Include the modules/libraries
local composer = require("composer")
local physics = require("physics")
local Hero = require("scenes.maze.lib.hero")

-- Cell class
local Cell = {}

function Cell:new(x, y)
	local data = {}
	setmetatable(data, { __index = Cell })
	data.x, data.y = x, y
	data.wallLeft = true
	data.wallTop = true
	data.visited = false
	data.distanceFromStart = 0
	return data
end

function Cell:updateWallLeft(wallLeft)
	self.wallLeft = wallLeft
	return self
end

function Cell:updateWallTop(wallTop)
	self.wallTop = wallTop
	return self
end

-- Stack class
local Stack = {}

function Stack.push(item)
    table.insert(Stack, item)
end

function Stack.pop()
    return table.remove(Stack)
end

-- Define module
local M = {}

function M.new(instance, options)
	-- Default options for instance
	local instance = {}
	local instanceGroup = display.newGroup()
	local options = options or {}
	local tileSize = options.tileSize or 32
	local imageSize = options.imageSize or 4
	local width = options.width + 1 or 15 + 1
	local height = options.height + 1 or 15 + 1
	local mazeStartX = (display.contentWidth - (tileSize * width)) / 2 -- Central position
	local mazeStartY = (display.contentHeight - (tileSize * height)) / 2 -- Central position
	local startCell, endCell
	local hero

	local dogPicture = display.newImageRect("scenes/maze/img/dog.png", 192, 192)
	dogPicture.x, dogPicture.y = 16 + 96, display.contentHeight - 16 - 96
	local bonePicture = display.newImageRect("scenes/maze/img/bone.png", 192, 192)
	bonePicture.x, bonePicture.y = display.contentWidth - 16 - 96, 16 + 96
	instanceGroup:insert(dogPicture)
	instanceGroup:insert(bonePicture)

	-- Generates a maze matrix
	function instance:generate()
		for x = 1, width do
			instance[x] = {}
			for y = height, 1, -1 do
				instance[x][y] = Cell:new(x, y)

				-- Generate inactive side parts
				if x < (imageSize + 1) and y > height - (imageSize + 1) or x > width - (imageSize + 1) and y < (imageSize + 1) then
					instance[x][y].visited = true
				end

			end
		end
		local rand = math.random(2)
		if rand == 2 then
			startCell = instance[math.random(imageSize)][height - 1 - imageSize]
		else
			startCell = instance[imageSize + 1][height - math.random(imageSize)]
		end
	end

	-- Generates a random maze path
	function instance:removeWalls()

		-- Generate inactive side parts
		for i = 1, imageSize do
			for k = 1, imageSize do
				instance[k][height + 1 - i].wallTop = false
				instance[width - k][i].wallTop = false
			end
		end
		for i = 1, imageSize do
			for k = 1, imageSize do
				instance[i][height - k].wallLeft = false
				instance[width + 1 - i][k].wallLeft = false
			end
		end

		local current = startCell
		local stack = Stack
		current.visited = true
		current.distanceFromStart = 0
		while current ~= nil do
			local unvisitedNeighbours = {}
			local x = current.x
			local y = current.y
			if x > 1 and not instance[x - 1][y].visited then table.insert(unvisitedNeighbours, instance[x - 1][y]) end -- Left direction
			if y > 1 and not instance[x][y - 1].visited then table.insert(unvisitedNeighbours, instance[x][y - 1]) end -- Top direction
			if x < width - 1 and not instance[x + 1][y].visited then table.insert(unvisitedNeighbours, instance[x + 1][y]) end -- Right direction
			if y < height - 1 and not instance[x][y + 1].visited then table.insert(unvisitedNeighbours, instance[x][y + 1]) end -- Bottom direction
			if #unvisitedNeighbours ~= 0 then
				local chosen = unvisitedNeighbours[math.random(#unvisitedNeighbours)]
				if (current.x == chosen.x) then
					if (current.y > chosen.y) then
						current.wallTop = false
					else
						chosen.wallTop = false
					end
				else
					if (current.x > chosen.x) then
						current.wallLeft = false
					else
						chosen.wallLeft = false
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

	-- Adds an exit to the furthest cell
	function instance:addExit()
		local furthest = startCell

		-- Random throughout the maze
		-- for x = 1, width do
		-- 	for y = 1, height do
		-- 		if instance[x][y].distanceFromStart > furthest.distanceFromStart then furthest = instance[x][y] end
		-- 	end
		-- end

		-- Random on the sides of the maze
		-- for x = 1, width do
		-- 	if instance[x][height - 1].distanceFromStart > furthest.distanceFromStart then furthest = instance[x][height - 1] end
		-- 	if instance[x][1].distanceFromStart > furthest.distanceFromStart then furthest = instance[x][1] end
		-- end
		-- for y = 1, height do
		-- 	if instance[width - 1][y].distanceFromStart > furthest.distanceFromStart then furthest = instance[width - 1][y] end
		-- 	if instance[1][y].distanceFromStart > furthest.distanceFromStart then furthest = instance[1][y] end
		-- end
		-- if furthest.x == 1 then
		-- 	furthest.wallLeft = false
		-- elseif furthest.y == 1 then
		-- 	furthest.wallTop = false
		-- elseif furthest.x == width - 1 then
		-- 	instance[furthest.x + 1][furthest.y].wallLeft = false
		-- elseif furthest.y == height - 1 then
		-- 	instance[furthest.x][furthest.y + 1].wallTop = false
		-- end

		for x = 1, width - 1 do
			for y = 1, height - 1 do
				if (y == imageSize + 1 and x > width - (imageSize + 1)) or (x == width - (imageSize + 1) and y < imageSize + 1) then
					if instance[x][y].distanceFromStart > furthest.distanceFromStart then furthest = instance[x][y] end
				end
			end
		end

		endCell = furthest

		if endCell.distanceFromStart < 140 then
			instance:generate()
			instance:removeWalls()
			instance:addExit()
			return
		end

		if endCell.y == imageSize + 1 then
			endCell.wallTop = false
			endCell = instance[endCell.x][endCell.y - 1]
		else
			instance[endCell.x + 1][endCell.y].wallLeft = false
			endCell = instance[endCell.x + 1][endCell.y]
		end
	end

	-- Draws a maze on the screen
	function instance:drawWalls()
		local strokeWidth = 4
		for x = 1, width do
			for y = 1, height do
				local cell, wallTop, wallLeft, text
				-- if instance[x][y].x == endCell.x and instance[x][y].y == endCell.y then
				-- 	cell = display.newCircle(0, 0, 8)
				-- 	cell.x = instance[x][y].x * tileSize + mazeStartX
				-- 	cell.y = instance[x][y].y * tileSize + mazeStartY
				-- 	cell:setFillColor(unpack({ 0.49, 0.22, 0.9, 1 }))
				-- 	instanceGroup:insert(cell)
				-- end
				-- cell = display.newRect(0, 0, tileSize, tileSize)
				-- cell.x = instance[x][y].x * tileSize + mazeStartX
				-- cell.y = instance[x][y].y * tileSize + mazeStartY
				-- if instance[x][y].x == startCell.x and instance[x][y].y == startCell.y then
				-- 	cell:setFillColor(unpack({ 0.02, 0.74, 0.04, 1 }))
				-- elseif instance[x][y].x == endCell.x and instance[x][y].y == endCell.y then
				-- 	cell:setFillColor(unpack({ 0.49, 0.22, 0.9, 1 }))
				-- else
				-- 	cell:setFillColor(unpack({ 1, 0.7, 0, 1 }))
				-- end
				-- text = display.newText(instance[x][y].distanceFromStart, 32, 32, native.systemFont, 14)
				-- text.x = instance[x][y].x * tileSize + mazeStartX
				-- text.y = instance[x][y].y * tileSize + mazeStartY
				-- text:setFillColor(unpack({ 0.02, 0.51, 0.25, 1 }))
				if instance[x][y].wallLeft then
					wallLeft = display.newRect(0, 0, strokeWidth, tileSize + strokeWidth)
					wallLeft.x = instance[x][y].x * tileSize - tileSize / 2 + mazeStartX
					wallLeft.y = instance[x][y].y * tileSize + mazeStartY
					wallLeft:setFillColor(unpack({ 0, 0, 0, 1 }))
					instanceGroup:insert(wallLeft)
				end
				if instance[x][y].wallTop then
					wallTop = display.newRect(0, 0, tileSize + strokeWidth, strokeWidth)
					wallTop.x = instance[x][y].x * tileSize + mazeStartX
					wallTop.y = instance[x][y].y * tileSize - tileSize / 2 + mazeStartY
					wallTop:setFillColor(unpack({ 0, 0, 0, 1 }))
					instanceGroup:insert(wallTop)
				end
				if instance[x][y] == startCell and startCell.x == imageSize + 1 then display.remove(wallLeft) end
				if instance[x][y - 1] == startCell and startCell.y == height - (imageSize + 1) then display.remove(wallTop) end
				if x == width then
					display.remove(wallTop)
					-- display.remove(cell)
					-- display.remove(text)
				end
				if y == height then
					display.remove(wallLeft)
					-- display.remove(cell)
					-- display.remove(text)
				end
			end
		end
	end

	function instance:addHero()
		hero = Hero:new(startCell.x * tileSize + mazeStartX, startCell.y * tileSize + mazeStartY, startCell)
		instanceGroup:insert(hero)
	end

	local lastEvent = {}
	local isMove = false
	local function key(event)
		local phase, keyName = event.phase, event.keyName
		if phase == lastEvent.phase and keyName == lastEvent.keyName then return false end
		if phase == "down" then
			if keyName == "left" or keyName == "a" then
				if not hero.currentCell.wallLeft and not isMove then
					isMove = true
					hero:update(hero.x - tileSize, hero.y, instance[hero.currentCell.x - 1][hero.currentCell.y])
					timer.performWithDelay(100, function () isMove = false end)
				end
			end
			if keyName == "right" or keyName == "d" then
				if not instance[hero.currentCell.x + 1][hero.currentCell.y].wallLeft and not isMove then
					isMove = true
					hero:update(hero.x + tileSize, hero.y, instance[hero.currentCell.x + 1][hero.currentCell.y])
					timer.performWithDelay(100, function () isMove = false end)
				end
			end
			if keyName == "up" or keyName == "w" then
				if not hero.currentCell.wallTop and not isMove then
					isMove = true
					hero:update(hero.x, hero.y - tileSize, instance[hero.currentCell.x][hero.currentCell.y - 1])
					timer.performWithDelay(100, function () isMove = false end)
				end
			end
			if keyName == "down" or keyName == "s" then
				if not instance[hero.currentCell.x][hero.currentCell.y + 1].wallTop and not isMove then
					isMove = true
					hero:update(hero.x, hero.y + tileSize, instance[hero.currentCell.x][hero.currentCell.y + 1])
					timer.performWithDelay(100, function () isMove = false end)
				end
			end
			if hero.currentCell == endCell then
				instance:finalize()
				local endText = display.newText("Лабиринт пройден!", 32, 32, "scenes/maze/font/geometria_bold.otf", 50)
				endText.alpha = 0.0
				endText.x = display.contentWidth / 2
				endText.y = display.contentHeight / 2
				transition.fadeIn(endText, { time = 500 })
				timer.performWithDelay(2000, function()
					display.remove(endText)
					composer.removeScene("scenes.maze")
					composer.gotoScene("menu", { })
				end)
			end
		end
		lastEvent = event
	end

	function instance:finalize()
		Runtime:removeEventListener("key", key)
		display.remove(instanceGroup)
	end

	instance:generate()
	instance:removeWalls()
	instance:addExit()
	instance:drawWalls()
	instance:addHero()

	Runtime:addEventListener("key", key)

	return instance
end

return M
