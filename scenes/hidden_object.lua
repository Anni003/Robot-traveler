local composer = require( "composer" )
local widget = require "widget"

local scene = composer.newScene()

bgMusicDoors = audio.loadStream( "menu-folder/music/resistors.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )
audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука

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

    local saw = display.newImageRect(hidden_object, "img/saw.png", 100, 80)
        saw.x = display.contentCenterX/0.99
        saw.y = display.contentCenterY/2.05
        hidden_object.size=hidden_object.size+1
        saw.text_x = display.contentCenterX/12
        sceneGroup:insert(saw)

    local pliers = display.newImageRect(hidden_object, p6, 95, 80)
        pliers.x = display.contentCenterX/0.53
        pliers.y = display.contentCenterY/0.63
        hidden_object.size=hidden_object.size+1
        pliers.text_x = display.contentCenterX/12+237;
        if (p6 == "img/wrench.png") then
            pliers.text = "Гаечные ключи"
        elseif (p6 == "img/hammer.png") then
            pliers.text = "Молоток"
        else
            pliers.text = "Плоскогубцы"
        end
        sceneGroup:insert(pliers)

    local scissors = display.newImageRect(hidden_object, p1, 90, 90)
        scissors.x = display.contentCenterX/1.7
        scissors.y = display.contentCenterY/0.74
        hidden_object.size=hidden_object.size+1
        scissors.text_x = display.contentCenterX/12+474;
        if (p1 == "img/scissors.png") then
            scissors.text = "Ножницы"
        elseif (p1 == "img/pump.png") then
            scissors.text = "Насос"
        else
            scissors.text = "Наждачка"
        end
        sceneGroup:insert(scissors)

    local sandpaper = display.newImageRect(hidden_object, p2, 100, 90)
        sandpaper.x = display.contentCenterX/4
        sandpaper.y = display.contentCenterY/0.65
        hidden_object.size=hidden_object.size+1
        sandpaper.text_x = display.contentCenterX/12+711;
        if (p2 == "img/scissors.png") then
            sandpaper.text = "Ножницы"
        elseif (p2 == "img/pump.png") then
            sandpaper.text = "Насос"
        else
            sandpaper.text = "Наждачка"
        end
        sceneGroup:insert(sandpaper)

    local ruler = display.newImageRect(hidden_object, "img/ruler.png", 160, 65)
        ruler.x = display.contentCenterX/1.9
        ruler.y = display.contentCenterY/2.35
        hidden_object.size=hidden_object.size+1
        ruler.text_x = display.contentCenterX/12+948;
        sceneGroup:insert(ruler)

    local hammer = display.newImageRect(hidden_object, p5, 95, 85)
        hammer.x = display.contentCenterX/0.75
        hammer.y = display.contentCenterY/0.68
        hidden_object.size=hidden_object.size+1
        hammer.text_x = display.contentCenterX/12+1185;
        if (p5 == "img/wrench.png") then
            hammer.text = "Гаечные ключи"
        elseif (p5 == "img/hammer.png") then
            hammer.text = "Молоток"
        else
            hammer.text = "Плоскогубцы"
        end
        sceneGroup:insert(hammer)

    local pump = display.newImageRect(hidden_object, p3,90, 90)
        pump.x = display.contentCenterX/0.51
        pump.y = display.contentCenterY/0.73
        hidden_object.size=hidden_object.size+1
        pump.text_x = display.contentCenterX/12+1422;
        if (p3 == "img/scissors.png") then
            pump.text = "Ножницы"
        elseif (p3 == "img/pump.png") then
            pump.text = "Насос"
        else
            pump.text = "Наждачка"
        end
        sceneGroup:insert(pump)

    local wrench = display.newImageRect(hidden_object, p4, 95, 90)
        wrench.x = display.contentCenterX/0.82
        wrench.y = display.contentCenterY/0.73
        hidden_object.size=hidden_object.size+1
        wrench.text_x = display.contentCenterX/12+1659;
        if (p4 == "img/wrench.png") then
            wrench.text = "Гаечные ключи"
        elseif (p4 == "img/hammer.png") then
            wrench.text = "Молоток"
        else
            wrench.text = "Плоскогубцы"
        end
        sceneGroup:insert(wrench)

    --Функция после удаления для всех объектов с экрана
    local function countDestroy()
        if hidden_object.size==0 then
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
        local line = display.newLine(self.text_x-90, display.contentCenterY/0.538, self.text_x+90, display.contentCenterY/0.538)
        line.strokeWidth = 7
        sceneGroup:insert(line)
        hidden_object.size=hidden_object.size-1
        countDestroy()
        return true
    end

    --Функция для динамического вывода текста из массива на экран
    local function text_view(array_text)
        x_text_start = display.contentCenterX/12
        for i=1, hidden_object.size do
            local text= display.newText(array_text[i], x_text_start, display.contentCenterY/0.54, "fonts/geometria_medium", 34)
            text:setFillColor(255,255,255)
            sceneGroup:insert(text)
            x_text_start = x_text_start+237
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

    --Таймер
	sec = widget.newButton {
		label = good_time,
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "puzzles folder/dif-images/btn-soberu.png",
		overFile = "puzzles folder/dif-images/btn-soberu.png",
		width = 80, height = 80,
	}
	sec.x = display.contentCenterX
	sec.y = display.contentHeight/14
    
	sceneGroup:insert( sec )
    local t = {}
    function t:timer( event )
        local count = event.count
        sec:setLabel( event.count )

        if (hidden_object.size==0) then
            time_1 = event.count
            timer.cancel( event.source )
        end
    end
    timer.performWithDelay( 1000, t, 0 )

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
	if phase == "did" then

		if musicGlobal == true then
			timer.performWithDelay( 5, function()
				audio.play( bgMusicDoors, { loops = -1, channel = 1 } ) -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
			end)
		end
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then
		
		if musicGlobal == true then
			audio.stop( 1 )    -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ
		end

	end	

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop(1)  -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ

end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene;
