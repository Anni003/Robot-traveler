local composer = require("composer")
local scene = composer.newScene()

local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view



-- ScrollView listener
local function scrollListener( event )
    return true
end


    local newRoundedRect = widget.newScrollView 
    {
        top = 0,
        left = 0,
        right = 0,
        width = 1500,
        horizontalScrollDisabled = true,
        backgroundColor={0,0,0, 0.9},

        topPadding = 1400,
        bottomPadding = 10, 
        leftPadding = 50, 
        rightPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = scrollListener
    }



    local lotsOfText = "Добро пожаловать в нашу игру!\
    \
    \
    Мы очень рады, что вы обратили внимание на\
    разработанную нами игру, мы очень старались.\
    \
    \
    Вашему вниманию представляется игра про Ро-\
    бота-путешественника. Вы должны помочь ему\
    пройти целых три уровня, которые спрятаны за\
    таинственными дверьми.\
    \
    \
    Первый уровень заключается в поиске предме-\
    тов. Внизу представлены названия различных\
    инструментов, которые необходимо\
    найти в лаборатории просто нажав на них.\
    \
    \
    На втором уровне вам нужно\
    найти выход из лабиринта, чтобы помочь роботу\
    подзарядиться.\
    \
    \
    И наконец финальный уровеь, где необходимо\
    помочь роботу собрать пазлы.\
    \
    \
    Осторожно, ваше время ограничено!\
    После прохождения игры вы попадете\
    в таблицу рейтинга. Чем быстрее вы\
    пройдете все игры, тем будет выше\
    ваше место в рейтинге.\
    Позже самые быстрые игроки смогут\
    поучавствовать в розыгрыше\
    призов на Робостации!"  

    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 700, 0, "fonts/geometria_light", 40)
    lotsOfTextObject:setTextColor( 255, 255, 255, 1 )
    lotsOfTextObject.x = display.contentCenterX/1.5

    newRoundedRect:insert(lotsOfTextObject)
    newRoundedRect.x = display.contentCenterX

    local okButton = widget.newButton {
        labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
        defaultFile = "menu-folder/images-for-menu/close-krest-simple.png",
        overFile = "menu-folder/images-for-menu/close-krest-simple.png",
        width = 52, height = 52,

        onPress = function(event)
            composer.hideOverlay( "fade", 400 )
		end
    }

    okButton.x = display.contentWidth-300
	okButton.y = display.contentCenterY - 430



    local picture = display.newImageRect( "menu-folder/images-for-menu/how-play-picture.png", 250, 300 )

	picture.x =  display.contentCenterX + 450
	picture.y = display.contentCenterY + 180



    
    sceneGroup:insert(newRoundedRect)
    sceneGroup:insert(okButton)
    sceneGroup:insert(picture)
end

-- Listener setup
scene:addEventListener( "create", scene )

-----------------------------------------------------------------------------------------

return scene