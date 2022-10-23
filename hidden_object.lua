-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--попробовать переделать через таблицы

local composer = require("composer");
local widget = require("widget");

local scene = composer.newScene(); -- создаём новую сцену
function scene:show(event)
	local backgroud = display.newImageRect("lab.jpg", display.contentWidth, display.contentHeight)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    -- list_2 = { next = { next = { next = { next = { next = nil, value = 1 }, value = 2 }, value = 3 }, value = 4 }, value = 5 }
    -- local l = list_2
    -- while l do
    --     text = display.newText(l, display.contentCenterX, display.contentCenterY)
    --     text:setFillColor(255,255,255)
    --     l = l.next
    -- end

    local text_scientist = display.newRect(800, 825, 1600, 150)
    text_scientist:setFillColor(0.5, 0.5, 0.5)

    local scientist = display.newImageRect("scientist.png", 230, 250)
    scientist.x = 1475
    scientist.y = 725

    local destroy_object = 0
    local count_object = 6*2

    local hidden_object = display.newGroup();

    local tubes = display.newImageRect(hidden_object, "colored_tubes.png", 100, 50);
    text = "tubes";
    tubes.x = 300;
    tubes.y = 575;

    local wrench = display.newImageRect(hidden_object, "wrench.png", 60, 50);
    text = "wrench";
    wrench.x = 1100;
    wrench.y = 575;

    local book = display.newImageRect(hidden_object, "book-shelf.png", 150, 100);
    book.x = 1275;
    book.y = 200;

    local robot_arm = display.newImageRect(hidden_object, "robot-arm.png", 150, 150);
    robot_arm.x = 1400;
    robot_arm.y = 520;

    local robot = display.newImageRect(hidden_object, "robot.png", 125, 150);
    robot.x = 725;
    robot.y = 650;

    local painting = display.newImageRect(hidden_object, "starry-night.png", 200, 150);
    painting.x = 250;
    painting.y = 275;

    array_text = {"Tubes", "Wrench", "Book", "Robot arm", "Robot", "Painting"}

    local var = 1
    for i=775, 825, 50 do
        for j=100, 1200, 400 do
            text_i = 
            {
                text = array_text[var],     
                x = j,
                y = i,
                font = native.systemFont,   
                fontSize = 18,
                align = "right",
                color = "white"  -- Alignment parameter
            }
            text = display.newText(text_i)
            text:setFillColor(255,255,255)
            var = var+1
        end
    end

    local text_destroy_all = 
    {
        text = "Поздравляю, вы собрали все предметы на этом уровне и нашли",     
        x = 700,
        y = 250,
        width = 700,
        font = native.systemFont,   
        fontSize = 22,
        align = "right"  -- Alignment parameter
    }

    local text_facts = 
    {
        text = "А вы знали, что...Американский инженер Д. Уэксли представил \nпервого робота на Всемирной выставке 1927 года в Нью-Йорке. \nРобот мог выполнять команды человека, воспроизводя \nфразы и совершая простые движения.",     
        x = 925,
        y = 500,
        width = 700,
        font = native.systemFont,   
        fontSize = 22,
        align = "left"  -- Alignment parameter
    }

    function count_destroy()
        destroy_object = destroy_object+1
        if destroy_object==count_object then
            sleep(1)
            local backgroud_black = display.newRect(800, 450, 1600, 900)
            backgroud_black:setFillColor(0, 0, 0, 0.8)
            local black = display.newRoundedRect(800, 450, 1300, 500, 17)
            black:setFillColor(0, 0, 0)
            local robot_left = display.newImageRect("robot_left.png", 300, 350);
            robot_left.x = 300;
            robot_left.y = 525;
            local window = display.newImageRect("window.png", 800, 350);
            window.x = 900;
            window.y = 525;
            local text_fact = display.newText(text_facts)
            text_fact:setFillColor(0, 0, 0)
            text = display.newText(text_destroy_all)
            text:setFillColor(255,255,255)
            local search_item = display.newImageRect("wrench.png", 60, 50);
            search_item.x = 1100
            search_item.y = 250
            btn = widget.newButton {
                shape = 'rect', 
                width = 400, height = 50, 
                x = 800,
                y = 325, 
                fontSize = 22, -- Размер шрифта
                fillColor = { default={ 76 / 255 }, over={ 150 / 255 } }, -- Цвет
                labelColor = { default={ 1 }, over={ 0 } }, -- Цвет текста
                label = "Вернуться к выбору уровня", -- Надпись
            
                -- Отслеживание нажатия
                onPress = function(event)
                    local composer_2 = require("composer");
                    composer_2.gotoScene("test");
                end
            }
        end
    end

    function sleep(n)
        if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
    end

    --изчезновение предмета при нажатии
    function destroy_tubes(event)
        tubes.x = -1000;
        tubes.y = -1000;
        sleep(0.7)
        display.newLine(50, 775, 150, 775).strokeWidth = 3
        count_destroy()
    end

    function destroy_book(event)
        book.x = -1000;
        book.y = -1000;
        sleep(0.7)
        display.newLine(850, 775, 950, 775).strokeWidth = 3
        count_destroy()
    end

    function destroy_robot_arm(event)
        robot_arm.x = -1000;
        robot_arm.y = -1000;
        sleep(0.7)
        display.newLine(50, 825, 150, 825).strokeWidth = 3
        count_destroy()
    end

    function destroy_robot(event)
        robot.x = -1000;
        robot.y = -1000;
        sleep(0.7)
        display.newLine(450, 825, 550, 825).strokeWidth = 3
        count_destroy()
    end

    function destroy_painting(event)
        painting.x = -1000;
        painting.y = -1000;
        sleep(0.7)
        display.newLine(850, 825, 950, 825).strokeWidth = 3
        count_destroy()
    end

    function destroy_wrench(event)
        wrench.x = -1000;
        wrench.y = -1000;
        sleep(0.7)
        display.newLine(450, 775, 550, 775).strokeWidth = 3
        count_destroy()
    end

    tubes:addEventListener("touch", destroy_tubes);
    robot_arm:addEventListener("touch", destroy_robot_arm);
    robot:addEventListener("touch", destroy_robot);
    book:addEventListener("touch", destroy_book);
    wrench:addEventListener("touch", destroy_wrench);
    painting:addEventListener("touch", destroy_painting);


    -- local hx = 800
    -- local hy = 0
    -- for i = 1, 18 do
    --     local myGrid = display.newRect(hx, hy, 1600, 2)
    --     myGrid:setFillColor(255, 0, 0)
    --     hy = hy+50
    -- end

    -- local vx = 0
    -- local vy = 450
    -- for i = 1, 33 do
    --     local myGrid = display.newRect(vx, vy, 2, 900)
    --     myGrid:setFillColor(255, 0, 0)
    --     vx = vx+50
    -- end



    -- system.activate( "multitouch" )
    
    -- book.numTouches = 0
    
    -- function book:touch( event )
    --     if event.phase == "began" then
    --         book:addEventListener("touch", destroy_book);
    --         self.numTouches = self.numTouches + 1
    
    --         if self.numTouches >= 2 then
    --             wrench:addEventListener("touch", destroy_wrench);
    --         end
    --     end
    --     return true
    -- end
    -- book:addEventListener( "touch", book )
end
scene:addEventListener("show", scene);
return scene;