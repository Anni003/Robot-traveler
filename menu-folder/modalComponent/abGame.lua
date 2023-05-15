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
        top = 0,
        left = 0,
        right = 0,
        width = 1400,
        horizontalScrollDisabled = true,
        backgroundColor={0,0,0, 0.9},

        topPadding = 1300,
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
    
    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 700, 0, "fonts/geometria_light", 40)
    lotsOfTextObject:setTextColor( 255, 255, 255 )
    lotsOfTextObject.x = display.contentCenterX + 50

    newRoundedRect.x = display.contentCenterX
    newRoundedRect:insert(lotsOfTextObject)


    
    newRoundedRect:scrollToPosition
    {
        y = -260,
        time = 19000
    }

    local okButton = widget.newButton {
        labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
        defaultFile = "menu-folder/images-for-menu/close-krest-simple.png",
        overFile = "menu-folder/images-for-menu/close-krest-simple.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }

    okButton.x = display.contentWidth - 20
	okButton.y = display.contentCenterY - 292



    local picture = display.newImageRect( "menu-folder/images-for-menu/how-play-picture.png", 250, 300 )

	picture.x =  display.contentCenterX + 450
	picture.y = display.contentCenterY + 180


    sceneGroup:insert(newRoundedRect)
    sceneGroup:insert(picture)
    sceneGroup:insert(okButton)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene

