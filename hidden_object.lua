local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
    display.setStatusBar(display.HiddenStatusBar)
    display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/location_1.jpg", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

    local hidden_object = display.newGroup()
    hidden_object.size = 0
    sceneGroup:insert(hidden_object)

    local tubes = display.newImageRect(hidden_object, "img/colored_tubes.png", 50, 25)
        tubes.x = display.contentCenterX/1.15
        tubes.y = display.contentCenterY/0.89
        hidden_object.size=hidden_object.size+1
        tubes.text_x = display.contentCenterX/8;
        sceneGroup:insert(tubes)

    local wrench = display.newImageRect(hidden_object, "img/wrench.png", 40, 25)
        wrench.x = display.contentCenterX/0.45
        wrench.y = display.contentCenterY/0.7
        hidden_object.size=hidden_object.size+1
        wrench.text_x = display.contentCenterX/8+150;
        sceneGroup:insert(wrench)
        
    --Функция задержки времени для более плавного перехода
    local function sleep(n)
        if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
    end

    --Функция после удаления для всех объектов с экрана
    local function countDestroy()
        if hidden_object.size==0 then
            sleep(0.9)
            composer.showOverlay("destroy_all", {
                isModal=true,
                effect="fade",
                time=400,
            })
        end
    end

    --Функция для сбора всех объектов
    local function onObjectTap( self, event )
        self:removeSelf()
        local line = display.newLine(self.text_x-50, display.contentCenterY/0.55, self.text_x+50, display.contentCenterY/0.55)
        line.strokeWidth = 2
        sceneGroup:insert(line)
        sleep(0.7)
        hidden_object.size=hidden_object.size-1
        countDestroy()
        return true
    end

    --Функция для динамического вывода текста из массива на экран
    local function text_view(array_text)
        x_text_start = display.contentCenterX/8
        for i=1, hidden_object.size do
            local text= display.newText(array_text[i], x_text_start, display.contentCenterY/0.55, native.systemFont, 12)
            text:setFillColor(255,255,255)
            sceneGroup:insert(text)
            x_text_start = x_text_start+150
        end
    end

    local array_text = {"Пробирки", "Гаечный ключ"}
    text_view(array_text)

    tubes.tap = onObjectTap
    tubes:addEventListener( "tap", tubes )
    wrench.tap = onObjectTap
    wrench:addEventListener( "tap", wrench )

end

scene:addEventListener("create", scene);
return scene;
