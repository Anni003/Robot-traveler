local composer = require("composer")
local physics = require("physics")
local tiled = require("com.ponywolf.ponytiled")
local json = require("json")
local widget = require("widget")--библиотека виджетов

local map, hero

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

	physics.start()
	physics.setGravity(0, 30)

    local filename = "scenes/platformer/map/sandbox.json"
    local mapData = json.decodeFile(system.pathForFile(filename, system.ResourceDirectory))
    map = tiled.new(mapData, "scenes/platformer/map")
    map.xScale, map.yScale = 1.5, 1.5

    map.extensions = "scenes.platformer.lib."
	map:extend("hero")
    hero = map:findObject("hero")

    map:extend("door")

    sceneGroup:insert(map)

    local leftButton, rightButton, jumpButton
    local isMobile = ("ios" == system.getInfo("platform")) or ("android" == system.getInfo("platform"))

    require("com.ponywolf.joykey").start()
    system.activate("multitouch")
    if isMobile then
        local vjoy = require("com.ponywolf.vjoy")
        leftButton = vjoy.newButton(20, "a")
        rightButton = vjoy.newButton(20, "d")
        jumpButton = vjoy.newButton(20, "space")
        leftButton.x, leftButton.y = 40, display.contentHeight - 60
        rightButton.x, rightButton.y = 90, display.contentHeight - 60
        jumpButton.x, jumpButton.y = display.contentWidth - 40, display.contentHeight - 60
    end


    --кнопка для перехода в меню
    local function goT0MenuBtn()
	
		composer.gotoScene( "menu", "fade", 400 )
		
		return true	-- indicates successful touch
	end
	menuBtn = widget.newButton {
		defaultFile = "burger-menu.png",
		overFile = "burger-menu-over.png",
		width = 60, height = 52,
		onRelease = goT0MenuBtn	-- event listener function
	}
	menuBtn.x = display.contentWidth + 70
	menuBtn.y = display.contentHeight - 292
    --кнопка для перехода в меню


    sceneGroup:insert(leftButton)
    sceneGroup:insert(rightButton)
    sceneGroup:insert(jumpButton)
    sceneGroup:insert(menuBtn) --добавлена кнопка для перехода в меню
end

local function scrollCamera(event)
	if hero and hero.x and hero.y then
		local x, y = hero:localToContent(0, 0)
		x, y = display.contentCenterX - x, display.contentCenterY - y
		map.x, map.y = map.x + x, map.y + y
	end
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        Runtime:addEventListener("enterFrame", scrollCamera)
    elseif (phase == "did") then

    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then

    elseif (phase == "did") then
        Runtime:removeEventListener("enterFrame", scrollCamera)
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
