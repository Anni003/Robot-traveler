local M = {}

local properties = {
	speed = 60,
	maxSpeed = 80,
	density = 2,
	bounce = 0,
	friction =  1.0
}

function M.new(instance)
    instance.isVisible = false
	local parent = instance.parent
	local x, y = instance.x, instance.y

	local sheetData = { width = 16, height = 16, numFrames = 6 }
	local sheet = graphics.newImageSheet("scenes/platformer/img/character-anim.png", sheetData)
	local sequenceData = {
		{ name = "idle", frames = { 1, 2 }, time = 700, loopCount = 0 },
		{ name = "walk", frames = { 3, 4, 5, 6 }, time = 400, loopCount = 0 },
		{ name = "jump", frames = { 2, 1 } },
	}
	instance = display.newSprite(parent, sheet, sequenceData)
	instance.x, instance.y = x, y
	instance:setSequence("idle")
	instance:play()

	local heroShape = { -5,-8, 5,-8, 5,8, -5,8 }
	physics.addBody(instance, "dynamic", { shape = heroShape, density = properties.density, bounce = properties.bounce, friction =  properties.friction })
	instance.isFixedRotation = true

	local left, right, flip = 0, 0, 0
	local lastEvent = {}
	local function key(event)
		local phase, keyName = event.phase, event.keyName
		if phase == lastEvent.phase and keyName == lastEvent.keyName then return false end
		if phase == "down" then
			if keyName == "left" or keyName == "a" then
				left = -properties.speed
				flip = -0.133
			end
			if keyName == "right" or keyName == "d" then
				right = properties.speed
				flip = 0.133
			elseif keyName == "space" or keyName == "up" then
				instance:jump()
			end
			if not (left == 0 and right == 0) and not instance.jumping then
				instance:setSequence("walk")
				instance:play()
			end
		elseif phase == "up" then
			if keyName == "left" or keyName == "a" then left = 0 end
			if keyName == "right" or keyName == "d" then right = 0 end
			if left == 0 and right == 0 and not instance.jumping then
				instance:setSequence("idle")
				instance:play()
			end
		end
		lastEvent = event
	end

    function instance:jump()
		if not instance.jumping then
			instance:applyLinearImpulse(0, -4.5)
			instance:setSequence("jump")
			instance.jumping = true
		end
	end

    local function enterFrame()
		local vx, vy = instance:getLinearVelocity()
		local dx = left + right
		if instance.jumping then dx = dx / 4 end
		if (dx < 0 and vx > -properties.maxSpeed) or (dx > 0 and vx < properties.maxSpeed) then
			instance:applyForce(dx or 0, 0, instance.x, instance.y)
		end
		instance.xScale = math.min(1, math.max(instance.xScale + flip, -1))
	end

    function instance:collision(event)
		local phase = event.phase
		local vx, vy = instance:getLinearVelocity()
		if phase == "began" then
			if instance.jumping and vy > 0 then
				instance.jumping = false
				if not (left == 0 and right == 0) and not instance.jumping then
					instance:setSequence("walk")
					instance:play()
				else
					instance:setSequence("idle")
					instance:play()
				end
			end
		end
	end

	function instance:finalize()
		instance:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame", enterFrame)
		Runtime:removeEventListener("key", key)
	end

	Runtime:addEventListener("enterFrame", enterFrame)
    Runtime:addEventListener("key", key)
    instance:addEventListener("collision")
	instance:addEventListener("finalize")

    instance.name = "hero"
	instance.type = "hero"
    return instance
end

return M
