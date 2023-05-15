local composer = require("composer")

local scene = composer.newScene()

function scene:show(event)
	local phase = event.phase
	local options = { params = event.params }
	if (phase == "will") then
		composer.removeScene("scenes.two_doors")
	elseif (phase == "did") then
		composer.gotoScene("scenes.two_doors", options)
	end
end

scene:addEventListener("show", scene)

return scene
