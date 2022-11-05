local composer = require("composer")
local physics = require("physics")
local tiled = require("com.ponywolf.ponytiled")
local json = require("json")
local custom = require("modules.button")

local door, map, hero

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local options = event.params

    local soundsDir = "scenes/platformer/sfx/"
    scene.sounds = {
        wind = audio.loadSound(soundsDir .. "spacewind.mp3"),
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
    end

    map:extend("door")
    door = map:findObject("door")
    if options then
        door.isClosed = true
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
        audio.play(self.sounds.wind, { loops = -1, fadein = 750, channel = 15 })
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        audio.fadeOut({ channel = 15, time = 1000 })
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
