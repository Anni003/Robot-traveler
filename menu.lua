local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view -- Group for adding scene display objects

	local text = display.newRect(20, 20, 20, 20)
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