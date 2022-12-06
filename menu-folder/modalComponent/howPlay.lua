local composer = require("composer")
local scene = composer.newScene()

local widget = require("widget")

function scene:create( event )
	local sceneGroup = self.view



-- ScrollView listener
local function scrollListener( event )
    return true
end


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
        backgroundColor={250,250,250, 0.9},

        topPadding = 650,
        bottomPadding = 10, 
        leftPadding = 50, 
        rightPadding = 50,
        horizontalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = scrollListener
    }



    local lotsOfText = "Ransomware is a form of malware. Malware also known isMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. MalwareMalware also known is aRansomware is a form of malware. Malware aRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware alsoRansomware is a form of malware. Malware also known is a form of malware. Malware also form of malware. Malware also known is a form of malware. Malware also known is a form of malware. Malware also known as malicious software refers to a program that is created with the intent of causing harm, this damage could take a range of forms, from destructive such as the deletion of files to compromising the confidentiality or integrity of the victim’s data or systems." 

    local lotsOfTextObject = display.newText( lotsOfText, 0, 0, 350, 0, "fonts/geometria_light", 16)
    lotsOfTextObject:setTextColor( 0, 0, 0 )
    lotsOfTextObject.x = display.contentCenterX

    newRoundedRect:insert(lotsOfTextObject)

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