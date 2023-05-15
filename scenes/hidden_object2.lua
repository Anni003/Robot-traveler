local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
    display.setStatusBar(display.HiddenStatusBar)
    display.setDefault("fillColor", 255, 255, 255)

    local background = display.newImageRect("img/location_2.jpg", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

    local hidden_object = display.newGroup()
    hidden_object.size = 0
    sceneGroup:insert(hidden_object)

    local _30 = {"img/knife.png", "img/compass.png", "img/saw_2.png"}
    local _50 = {"img/machine.png", "img/wrench_2.png", "img/pliers_2.png"}

    p1 = _30[math.random(#_30)]
    p2 = _30[math.random(#_30)]
    p3 = _30[math.random(#_30)]
    while (p2==p1 or p3==p2 or p3==p1) do
        p2 = _30[math.random(#_30)]
        p3 = _30[math.random(#_30)]
    end

    p4 = _50[math.random(#_50)]
    p5 = _50[math.random(#_50)]
    p6 = _50[math.random(#_50)]
    while (p5==p4 or p5==p6 or p6==p4) do
        p5 = _50[math.random(#_50)]
        p6 = _50[math.random(#_50)]
    end

    local roulette = display.newImageRect(hidden_object, "img/roulette.png", 30, 35)
        roulette.x = display.contentCenterX/0.67
        roulette.y = display.contentCenterY/1.2
        hidden_object.size=hidden_object.size+1
        roulette.text_x = display.contentCenterX/12;
        sceneGroup:insert(roulette)

    local knife = display.newImageRect(hidden_object, p1, 60, 46)
        knife.x = display.contentCenterX/0.59
        knife.y = display.contentCenterY/1.8
        hidden_object.size=hidden_object.size+1
        knife.text_x = display.contentCenterX/12+135;
        if (p1 == "img/knife.png") then
            knife.text = "Канцелярский нож"
        elseif (p1 == "img/compass.png") then
            knife.text = "Циркуль"
        else
            knife.text = "Пила"
        end
        sceneGroup:insert(knife)

    local compass = display.newImageRect(hidden_object, p2, 60, 60)
        compass.x = display.contentCenterX/0.5
        compass.y = display.contentCenterY/1.9
        hidden_object.size=hidden_object.size+1
        compass.text_x = display.contentCenterX/12+270;
        if (p2 == "img/knife.png") then
            compass.text = "Канцелярский нож"
        elseif (p2 == "img/compass.png") then
            compass.text = "Циркуль"
        else
            compass.text = "Пила"
        end
        sceneGroup:insert(compass)

    local machine = display.newImageRect(hidden_object, p4, 100, 90)
        machine.x = display.contentCenterX/1.1
        machine.y = display.contentCenterY/0.81
        hidden_object.size=hidden_object.size+1
        machine.text_x = display.contentCenterX/12+405;
        if (p4 == "img/machine.png") then
            machine.text = "Станок"
        elseif (p4 == "img/wrench_2.png") then
            machine.text = "Ключ"
        else
            machine.text = "Кусачки"
        end
        sceneGroup:insert(machine)

    local wrench_2 = display.newImageRect(hidden_object, p5, 110, 90)
        wrench_2.x = display.contentCenterX/100-170
        wrench_2.y = display.contentCenterY/0.73
        hidden_object.size=hidden_object.size+1
        wrench_2.text_x = display.contentCenterX/12+540;
        if (p5 == "img/machine.png") then
            wrench_2.text = "Станок"
        elseif (p5 == "img/wrench_2.png") then
            wrench_2.text = "Ключ"
        else
            wrench_2.text = "Кусачки"
        end
        sceneGroup:insert(wrench_2)

    local saw_2 = display.newImageRect(hidden_object, p3, 60, 60)
        saw_2.x = display.contentCenterX/100-155
        saw_2.y = display.contentCenterY/5.1
        hidden_object.size=hidden_object.size+1
        saw_2.text_x = display.contentCenterX/12+675;
        if (p3 == "img/knife.png") then
            saw_2.text = "Канцелярский нож"
        elseif (p3 == "img/compass.png") then
            saw_2.text = "Циркуль"
        else
            saw_2.text = "Пила"
        end
        sceneGroup:insert(saw_2)

    local microscope = display.newImageRect(hidden_object, "img/microscope.png",290, 160)
        microscope.x = display.contentCenterX/100-250
        microscope.y = display.contentCenterY/1.15
        hidden_object.size=hidden_object.size+1
        microscope.text_x = display.contentCenterX/12+810;
        sceneGroup:insert(microscope)

    local pliers_2 = display.newImageRect(hidden_object, p6, 100, 90)
        pliers_2.x = display.contentCenterX/0.49
        pliers_2.y = display.contentCenterY/1.3
        hidden_object.size=hidden_object.size+1
        pliers_2.text_x = display.contentCenterX/12+945;
        if (p6 == "img/machine.png") then
            pliers_2.text = "Станок"
        elseif (p6 == "img/wrench_2.png") then
            pliers_2.text = "Ключ"
        else
            pliers_2.text = "Кусачки"
        end
        sceneGroup:insert(pliers_2)

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
        local line = display.newLine(self.text_x-45, display.contentCenterY/0.54, self.text_x+45, display.contentCenterY/0.54)
        line.strokeWidth = 3
        line:setStrokeColor( 255, 255, 255, 1 )
        sceneGroup:insert(line)
        sleep(0.7)
        hidden_object.size=hidden_object.size-1
        countDestroy()
        return true
    end

    --Функция для динамического вывода текста из массива на экран
    local function text_view(array_text)
        x_text_start = display.contentCenterX/12
        for i=1, hidden_object.size do
            local text= display.newText(array_text[i], x_text_start, display.contentCenterY/0.54, "fonts/geometria_medium", 17)
            text:setFillColor(255,255,255)
            sceneGroup:insert(text)
            x_text_start = x_text_start+135
        end
    end

    local array_text = {"Рулетка", knife.text, compass.text, machine.text, wrench_2.text, saw_2.text, "Микроскоп",  pliers_2.text}
    text_view(array_text)

    roulette.tap = onObjectTap
    roulette:addEventListener( "tap", roulette )
    knife.tap = onObjectTap
    knife:addEventListener( "tap", knife )
    compass.tap = onObjectTap
    compass:addEventListener( "tap", compass )
    machine.tap = onObjectTap
    machine:addEventListener( "tap", machine)
    wrench_2.tap = onObjectTap
    wrench_2:addEventListener( "tap", wrench_2)
    saw_2.tap = onObjectTap
    saw_2:addEventListener( "tap", saw_2)
    microscope.tap = onObjectTap
    microscope:addEventListener( "tap", microscope)
    pliers_2.tap = onObjectTap
    pliers_2:addEventListener( "tap", pliers_2)

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
