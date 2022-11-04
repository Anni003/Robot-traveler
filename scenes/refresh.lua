local composer = require("composer")

local scene = composer.newScene()

function scene:show(event)
	local phase = event.phase
	local options = { params = event.params }
	if (phase == "will") then
		composer.removeScene("scenes.platformer")
	elseif (phase == "did") then
		composer.gotoScene("scenes.platformer", options)
	end
end

scene:addEventListener("show", scene)

return scene
