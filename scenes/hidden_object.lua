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

    local _30 = {"img/scissors.png", "img/sandpaper.png", "img/pump.png"}
    local _25 = {"img/wrench.png", "img/hammer.png", "img/pliers.png"}

    p1 = _30[math.random(#_30)]
    p2 = _30[math.random(#_30)]
    p3 = _30[math.random(#_30)]
    while (p2==p1 or p3==p2 or p3==p1) do
        p2 = _30[math.random(#_30)]
        p3 = _30[math.random(#_30)]
    end

    p4 = _25[math.random(#_25)]
    p5 = _25[math.random(#_25)]
    p6 = _25[math.random(#_25)]
    while (p5==p4 or p5==p6 or p6==p4) do
        p5 = _25[math.random(#_25)]
        p6 = _25[math.random(#_25)]
    end

    local saw = display.newImageRect(hidden_object, "img/saw.png", 70, 50)
        saw.x = display.contentCenterX/0.99
        saw.y = display.contentCenterY/2.05
        hidden_object.size=hidden_object.size+1
        saw.text_x = display.contentCenterX/100-35;
        sceneGroup:insert(saw)

    local pliers = display.newImageRect(hidden_object, p6, 65, 50)
        pliers.x = display.contentCenterX/0.5
        pliers.y = display.contentCenterY/0.63
        hidden_object.size=hidden_object.size+1
        pliers.text_x = display.contentCenterX/100-35+150;
        if (p6 == "img/wrench.png") then
            pliers.text = "Гаечные ключи"
        elseif (p6 == "img/hammer.png") then
            pliers.text = "Молоток"
        else
            pliers.text = "Плоскогубцы"
        end
        sceneGroup:insert(pliers)

    local scissors = display.newImageRect(hidden_object, p1, 60, 60)
        scissors.x = display.contentCenterX/2.1
        scissors.y = display.contentCenterY/0.74
        hidden_object.size=hidden_object.size+1
        scissors.text_x = display.contentCenterX/100-35+300;
        if (p1 == "img/scissors.png") then
            scissors.text = "Ножницы"
        elseif (p1 == "img/pump.png") then
            scissors.text = "Насос"
        else
            scissors.text = "Наждачка"
        end
        sceneGroup:insert(scissors)

    local sandpaper = display.newImageRect(hidden_object, p2, 70, 60)
        sandpaper.x = display.contentCenterX/65
        sandpaper.y = display.contentCenterY/0.65
        hidden_object.size=hidden_object.size+1
        sandpaper.text_x = display.contentCenterX/100-35+450;
        if (p2 == "img/scissors.png") then
            sandpaper.text = "Ножницы"
        elseif (p2 == "img/pump.png") then
            sandpaper.text = "Насос"
        else
            sandpaper.text = "Наждачка"
        end
        sceneGroup:insert(sandpaper)

    local ruler = display.newImageRect(hidden_object, "img/ruler.png", 130, 35)
        ruler.x = display.contentCenterX/3.7
        ruler.y = display.contentCenterY/2.35
        hidden_object.size=hidden_object.size+1
        ruler.text_x = display.contentCenterX/100-35+600;
        sceneGroup:insert(ruler)

    local hammer = display.newImageRect(hidden_object, p5, 65, 55)
        hammer.x = display.contentCenterX/0.75
        hammer.y = display.contentCenterY/0.68
        hidden_object.size=hidden_object.size+1
        hammer.text_x = display.contentCenterX/100-35+750;
        if (p5 == "img/wrench.png") then
            hammer.text = "Гаечные ключи"
        elseif (p5 == "img/hammer.png") then
            hammer.text = "Молоток"
        else
            hammer.text = "Плоскогубцы"
        end
        sceneGroup:insert(hammer)

    local pump = display.newImageRect(hidden_object, p3,60, 60)
        pump.x = display.contentCenterX/0.408
        pump.y = display.contentCenterY/0.73
        hidden_object.size=hidden_object.size+1
        pump.text_x = display.contentCenterX/100-35+900;
        if (p3 == "img/scissors.png") then
            pump.text = "Ножницы"
        elseif (p3 == "img/pump.png") then
            pump.text = "Насос"
        else
            pump.text = "Наждачка"
        end
        sceneGroup:insert(pump)

    local wrench = display.newImageRect(hidden_object, p4, 65, 60)
        wrench.x = display.contentCenterX/0.82
        wrench.y = display.contentCenterY/0.73
        hidden_object.size=hidden_object.size+1
        wrench.text_x = display.contentCenterX/100-35+1050;
        if (p4 == "img/wrench.png") then
            wrench.text = "Гаечные ключи"
        elseif (p4 == "img/hammer.png") then
            wrench.text = "Молоток"
        else
            wrench.text = "Плоскогубцы"
        end
        sceneGroup:insert(wrench)

    --Функция задержки времени для более плавного перехода
    local function sleep(n)
        if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
    end

    --Функция после удаления для всех объектов с экрана
    local function countDestroy()
        if hidden_object.size==0 then
            sleep(0.9)
            composer.showOverlay("scenes.destroy_all", {
                isModal=true,
                effect="fade",
                time=400,
            })
        end
    end

    --Функция для сбора всех объектов
    local function onObjectTap( self, event )
        self:removeSelf()
        local line = display.newLine(self.text_x-63, display.contentCenterY/0.54, self.text_x+63, display.contentCenterY/0.54)
        line.strokeWidth = 3
        sceneGroup:insert(line)
        sleep(0.7)
        hidden_object.size=hidden_object.size-1
        countDestroy()
        return true
    end

    --Функция для динамического вывода текста из массива на экран
    local function text_view(array_text)
        x_text_start = display.contentCenterX/100-35
        for i=1, hidden_object.size do
            local text= display.newText(array_text[i], x_text_start, display.contentCenterY/0.54, "fonts/geometria_medium", 20)
            text:setFillColor(255,255,255)
            sceneGroup:insert(text)
            x_text_start = x_text_start+150
        end
    end

    local array_text = {"Пила", pliers.text,  scissors.text, sandpaper.text, "Линейка", hammer.text,  pump.text, wrench.text}
    text_view(array_text)

    saw.tap = onObjectTap
    saw:addEventListener( "tap", saw )
    pliers.tap = onObjectTap
    pliers:addEventListener( "tap", pliers )
    scissors.tap = onObjectTap
    scissors:addEventListener( "tap", scissors )
    sandpaper.tap = onObjectTap
    sandpaper:addEventListener( "tap", sandpaper)
    ruler.tap = onObjectTap
    ruler:addEventListener( "tap", ruler)
    hammer.tap = onObjectTap
    hammer:addEventListener( "tap", hammer)
    pump.tap = onObjectTap
    pump:addEventListener( "tap", pump)
    wrench.tap = onObjectTap
    wrench:addEventListener( "tap", wrench)

    --кнопка для перехода в меню
    local function goT0MenuBtn()
	
		composer.gotoScene( "menu", "fade", 400 )
		
		return true	-- indicates successful touch
	end
	menuBtn = widget.newButton {
		defaultFile = "menu-folder/images-for-menu/burger-menu.png",
		overFile = "menu-folder/images-for-menu/burger-menu-over.png",
		width = 80, height = 62,
		onRelease = goT0MenuBtn	-- event listener function
	}
	menuBtn.x = display.contentWidth/0.82
	menuBtn.y = display.contentHeight/15
    --кнопка для перехода в меню
    sceneGroup:insert(menuBtn) --добавлена кнопка для перехода в меню

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then

	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then

	end	
	
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener("create", scene);
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene;
