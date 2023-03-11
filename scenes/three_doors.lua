local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )
    local sceneGroup = self.view
        display.setStatusBar(display.HiddenStatusBar)
        display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/doors.png", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

    local doors = display.newGroup()
        sceneGroup:insert(doors)

    local door_1 = display.newImageRect(doors, "img/door-1.png", 320, 490)
        door_1.x = display.contentCenterX/25
        door_1.y = display.contentCenterY/1.459
        sceneGroup:insert(door_1)

    local door_2 = display.newImageRect(doors, "img/door-2.png", 300, 490)
        door_2.x = display.contentCenterX
        door_2.y = display.contentCenterY/1.45
        sceneGroup:insert(door_2)

    local door_3 = display.newImageRect(doors, "img/door-3.png", 300, 490)
        door_3.x = display.contentCenterX/0.51
        door_3.y = display.contentCenterY/1.458
        sceneGroup:insert(door_3)

    
    local list = {"scenes.hidden_object3", "scenes.hidden_object2", "scenes.hidden_object"}

    local function open_door_1()
        local array = list[math.random(#list)]
        composer.gotoScene(array)
    end

    local function open_door_2()
        composer.gotoScene("scenes.labyrinth")
    end

    local function open_door_3()
        composer.gotoScene("scenes.puzzleGame")
    end
    
    door_1:addEventListener( "tap", open_door_1 )
    door_2:addEventListener( "tap", open_door_2 )
    door_3:addEventListener( "tap", open_door_3 )
end

scene:addEventListener("create", scene);
return scene;
