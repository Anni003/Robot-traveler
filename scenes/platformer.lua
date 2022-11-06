local composer = require("composer")
local physics = require("physics")
local tiled = require("com.ponywolf.ponytiled")
local json = require("json")
local widget = require("widget") -- библиотека виджетов
local custom = require("modules.button")

local door, map, hero

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local options = event.params

    local soundsDir = "scenes/platformer/sfx/"
    scene.sounds = {
        jumping = audio.loadSound(soundsDir .. "jumping.mp3"),
        door = audio.loadSound(soundsDir .. "door.mp3"),
        walk = audio.loadSound(soundsDir .. "walk.mp3"),
    }

	physics.start()
	physics.setGravity(0, 30)

    local filename = "scenes/platformer/map/sandbox.json"
    local mapData = json.decodeFile(system.pathForFile(filename, system.ResourceDirectory))
    map = tiled.new(mapData, "scenes/platformer/map")
    map.xScale, map.yScale = 1.5, 1.5

    map.extensions = "scenes.platformer.lib."
	map:extend("hero")
    hero = map:findObject("hero")

    if options then
        hero.x, hero.y = options.hero_x, options.hero_y
        if options.hero_direction == "right" then
            hero.xScale = 1
            hero.direction = "right"
        elseif options.hero_direction == "left" then
            hero.xScale = -1
            hero.direction = "left"
        end
    end

    map:extend("door")
    door = map:findObject("door")
    if options then
        door.isClosed = options.isClosed
    end

    sceneGroup:insert(map)

    local isMobile = ("ios" == system.getInfo("platform")) or ("android" == system.getInfo("platform"))

    if isMobile then
        system.activate("multitouch")
        local leftButton = custom.newButton("🡸", "a", 40, display.contentHeight - 60)
        local rightButton = custom.newButton("🡺", "d", 90, display.contentHeight - 60)
        local jumpButton = custom.newButton("🡹", "space", display.contentWidth - 40, display.contentHeight - 60)
        sceneGroup:insert(leftButton)
        sceneGroup:insert(rightButton)
        sceneGroup:insert(jumpButton)
    end


    -- кнопка для перехода в меню
    local function goT0MenuBtn()

		composer.gotoScene( "menu", { params = { hero_x = hero.x, hero_y = hero.y, hero_direction = hero.direction, isClosed = door.isClosed } }, "fade", 400 )

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
    -- кнопка для перехода в меню

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
        hero:finalize()
        Runtime:removeEventListener("enterFrame", scrollCamera)
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
    audio.stop()
    for s, v in pairs(self.sounds) do
        audio.dispose(v)
        self.sounds[s] = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
