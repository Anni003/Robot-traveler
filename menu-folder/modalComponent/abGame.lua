local composer = require("composer")
local scene = composer.newScene()

local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view


    local rect = display.newRect(sceneGroup, display.contentCenterX,
    display.contentCenterY, display.contentWidth + 350,
    display.contentHeight + 150):setFillColor(37/255, 39/255, 46/255, 0.7)

    local newRoundedRect = widget.newScrollView 
    {
        top = 65,
        left = 0,
        right = 0,
        width = 900,
        horizontalScrollDisabled = true,
        backgroundColor={250,250,250, 1},

        topPadding = 550,
        bottomPadding5= 10, 
        leftPadding = 50, 
        rightPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = scrollListener
    }




    local lotsOfText = "Об игре <<Робот-путешественник>>\
    \
    \
    Игра разработана студентами\
    Московского Политехнического Университета\
    в рамках дисциплины <<Проектная деятельность>>\
    \
    \
    Дизайн:\
    Яна Шелудько\
    Виктория Сухорученкова\
    \
    \
    Программирование:\
    Артем Кузнецов\
    Анна Хорошилова\
    Мукомел Наталия\
    \
    \
    Управление командой и сюжет:\
    Екатерина Спицына\
    Екатерина Курсина\
    \
    \
    Куратор проекта: Никулина Анна\
    \
    \
    Большое спасибо, что играете в нашу игру!\
    \
    Московский Политехнический Университет\
    для Робостанции ВДНХ\
    2022г" 
    
    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 330, 0, "fonts/geometria_light", 20)
    lotsOfTextObject:setTextColor( 0, 0, 0 )
    lotsOfTextObject.x = display.contentCenterX - 20

    newRoundedRect:insert(lotsOfTextObject)

    
    newRoundedRect:scrollToPosition
    {
        y = -260,
        time = 19000
    }

    local okButton = widget.newButton {
        labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
        defaultFile = "menu-folder/images-for-menu/close.png",
        overFile = "menu-folder/images-for-menu/close-over.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }

    okButton.x = display.contentWidth - 20
	okButton.y = display.contentCenterY - 292



    sceneGroup:insert(okButton)
    sceneGroup:insert(newRoundedRect)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene