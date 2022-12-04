-- Include the modules/libraries
local composer = require("composer")
local physics = require("physics")
local Maze = require("scenes.maze.lib.maze")

-- Local variables for the scene
local maze

-- Create a new Composer scene
local scene = composer.newScene()

-- This function is called when scene is created
function scene:create(event)
	local sceneGroup = self.view -- Group for adding scene display objects

	-- Adding physics
	physics.start()
	physics.setGravity(0, 0)

	-- Adding background
	display.setDefault("background", 0.59, 0.84, 0.91)
	-- local background = display.newImageRect("scenes/maze/img/background.png", display.contentWidth, display.contentHeight)
	-- background.x, background.y = display.contentCenterX, display.contentCenterY

	-- Create maze
	maze = Maze:new({ width = 31, height = 23, tileSize = 32, imageSize = 6 })

	-- sceneGroup:insert(background)
end

-- This function is called when scene comes fully on screen
function scene:show(event)
	local phase = event.phase
	if (phase == "will") then

	elseif (phase == "did") then

	end
end

-- This function is called when scene goes fully off screen
function scene:hide(event)
	local phase = event.phase
	if (phase == "will") then

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
