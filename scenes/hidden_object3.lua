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

    local background = display.newImageRect("img/location_3.jpg", display.actualContentWidth, display.actualContentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
        sceneGroup:insert(background)

    local hidden_object = display.newGroup()
    hidden_object.size = 0
    sceneGroup:insert(hidden_object)

    local _30 = {"img/protractor.png", "img/screwdriver.png"}
    local _40 = {"img/saw_3.png", "img/microscope_3.png"}
    local _45 = {"img/wrench_3.png", "img/drill.png"}
    local _50 = {"img/pliers_3.png", "img/bulgarian.png"}

    p1 = _30[math.random(#_30)]
    p2 = _30[math.random(#_30)]
    while p2==p1 do
        p2 = _30[math.random(#_30)]
    end

    p3 = _40[math.random(#_40)]
    p4 = _40[math.random(#_40)]
    while p4==p3 do
        p4 = _40[math.random(#_40)]
    end

    p5 = _45[math.random(#_45)]
    p6 = _45[math.random(#_45)]
    while p6==p5 do
        p6 = _45[math.random(#_45)]
    end

    p7 = _50[math.random(#_50)]
    p8 = _50[math.random(#_50)]
    while p8==p7 do
        p8 = _50[math.random(#_50)]
    end
    local protractor = display.newImageRect(hidden_object, p1, 90, 90)
        protractor.x = display.contentCenterX/0.535
        protractor.y = display.contentCenterY/1.2
        hidden_object.size=hidden_object.size+1
        protractor.text_x = display.contentCenterX/8;
        if (p1 == "img/screwdriver.png") then
            protractor.text = "Отвёртка"
        else
            protractor.text = "Угломер"
        end
        sceneGroup:insert(protractor)

    local wrench_3 = display.newImageRect(hidden_object, p5, 120, 110)
        wrench_3.x = display.contentCenterX/0.6
        wrench_3.y = display.contentCenterY/0.86
        hidden_object.size=hidden_object.size+1
        wrench_3.text_x = display.contentCenterX/8+237;
        if (p5 == "img/drill.png") then
            wrench_3.text = "Свёрла"
        else
            wrench_3.text = "Гаечные ключи"
        end
        sceneGroup:insert(wrench_3)

    local screwdriver = display.newImageRect(hidden_object, p2, 120, 120)
        screwdriver.x = display.contentCenterX/0.73
        screwdriver.y = display.contentCenterY/0.76
        hidden_object.size=hidden_object.size+1
        screwdriver.text_x = display.contentCenterX/8+474;
        if (p2 == "img/screwdriver.png") then
            screwdriver.text = "Отвёртка"
        else
            screwdriver.text = "Угломер"
        end
        sceneGroup:insert(screwdriver)

    local bulgarian = display.newImageRect(hidden_object, p7, 130, 120)
        bulgarian.x = display.contentCenterX/2
        bulgarian.y = display.contentCenterY/0.645
        hidden_object.size=hidden_object.size+1
        bulgarian.text_x = display.contentCenterX/8+711;
        if (p7 == "img/bulgarian.png") then
            bulgarian.text = "Болгарка"
        else
            bulgarian.text = "Кусачки"
        end
        sceneGroup:insert(bulgarian)

    local drill = display.newImageRect(hidden_object, p6, 120, 110)
        drill.x = display.contentCenterX/1.6
        drill.y = display.contentCenterY/0.83
        hidden_object.size=hidden_object.size+1
        drill.text_x = display.contentCenterX/8+948;
        if (p6 == "img/drill.png") then
            drill.text = "Свёрла"
        else
            drill.text = "Гаечные ключи"
        end
        sceneGroup:insert(drill)

    local saw_3 = display.newImageRect(hidden_object, p3, 110, 110)
        saw_3.x = display.contentCenterX/0.64
        saw_3.y = display.contentCenterY/2.4
        hidden_object.size=hidden_object.size+1
        saw_3.text_x = display.contentCenterX/8+1185;
        if (p3 == "img/microscope_3.png") then
            saw_3.text = "Микроскоп"
        else
            saw_3.text = "Пила"
        end
        sceneGroup:insert(saw_3)

    local microscope_3 = display.newImageRect(hidden_object, p4, 110, 110)
        microscope_3.x = display.contentCenterX/1.3
        microscope_3.y = display.contentCenterY/1.22
        hidden_object.size=hidden_object.size+1
        microscope_3.text_x = display.contentCenterX/8+1422;
        if (p4 == "img/microscope_3.png") then
            microscope_3.text = "Микроскоп"
        else
            microscope_3.text = "Пила"
        end
        sceneGroup:insert(microscope_3)

    local pliers_3 = display.newImageRect(hidden_object, p8, 130, 120)
        pliers_3.x = display.contentCenterX/0.8
        pliers_3.y = display.contentCenterY/1.17
        hidden_object.size=hidden_object.size+1
        pliers_3.text_x = display.contentCenterX/8+1659;
        if (p8 == "img/bulgarian.png") then
            pliers_3.text = "Болгарка"
        else
            pliers_3.text = "Кусачки"
        end
        sceneGroup:insert(pliers_3)

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
        x_text_start = display.contentCenterX/8
        for i=1, hidden_object.size do
            local text= display.newText(array_text[i], x_text_start, display.contentCenterY/0.54, "fonts/geometria_medium", 34)
            text:setFillColor(255,255,255)
            sceneGroup:insert(text)
            x_text_start = x_text_start+237
        end
    end

    local array_text = {protractor.text, wrench_3.text, screwdriver.text, bulgarian.text, drill.text, saw_3.text, microscope_3.text,  pliers_3.text}
    text_view(array_text)

    protractor.tap = onObjectTap
    protractor:addEventListener( "tap", protractor )
    wrench_3.tap = onObjectTap
    wrench_3:addEventListener( "tap", wrench_3 )
    screwdriver.tap = onObjectTap
    screwdriver:addEventListener( "tap", screwdriver )
    bulgarian.tap = onObjectTap
    bulgarian:addEventListener( "tap", bulgarian)
    drill.tap = onObjectTap
    drill:addEventListener( "tap", drill)
    saw_3.tap = onObjectTap
    saw_3:addEventListener( "tap", saw_3)
    microscope_3.tap = onObjectTap
    microscope_3:addEventListener( "tap", microscope_3)
    pliers_3.tap = onObjectTap
    pliers_3:addEventListener( "tap", pliers_3)

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
