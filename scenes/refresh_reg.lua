local composer = require("composer")

local scene = composer.newScene()
    
--Функция задержки времени для более плавного перехода
local function sleep(n)
	if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end

function scene:show(event)
	local phase = event.phase
	local options = { params = event.params }
	if (phase == "will") then
		composer.removeScene("scenes.reg")
	elseif (phase == "did") then
		sleep(0.7);
		composer.gotoScene("scenes.reg", options)
	end
end

scene:addEventListener("show", scene)

return scene
