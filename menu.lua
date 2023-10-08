local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local playBtn

bgMusic = audio.loadStream( "menu-folder/music/menu-bg.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )

--audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука

local function onPlayBtnRelease()
	composer.gotoScene( "scenes.one_doors", "fade", 400 )
	return true	-- indicates successful touch
end

      
function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "menu-folder/images-for-menu/fon-glavnoe-menu.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX
	background.y = 0 + display.screenOriginY
	

	playBtn = widget.newButton { --начать игру
		label = "",
		fontSize = 35,
		font = "fonts/geometria_bold",
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/start-game.png",
		overFile = "menu-folder/images-for-menu/start-game.png",
		width = 800, height = 200,
		onRelease = onPlayBtnRelease
	}
	playBtn.x = display.contentCenterX - 500
	playBtn.y = display.contentCenterY - 80


	local settingsBtn = widget.newButton{
		label = "",
		font = "fonts/geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/settings.png",
		overFile = "menu-folder/images-for-menu/settings.png",
		width = 800, height = 200,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.settingsModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	settingsBtn.x = display.contentCenterX - 500
	settingsBtn.y = display.contentCenterY + 130





	local referenceBtn = widget.newButton{
		label = "",
		font = "fonts/geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/reference.png",
		overFile = "menu-folder/images-for-menu/reference.png",
		width = 800, height = 200,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.referenceModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	referenceBtn.x = display.contentCenterX - 500
	referenceBtn.y = display.contentCenterY + 325

	sceneGroup:insert( background )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( settingsBtn )
	sceneGroup:insert( referenceBtn )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if phase == "will" then

	elseif phase == "did" then

		print("это фаза show")
		audio.play( bgMusic, { loops = -1, channel = 1 } )
				 -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
				-- audio.fade({ channel = 1, time = 100, volume = 0.1 } )
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then
		
		if musicGlobal == true then
			-- audio.fadeOut( { channel = 2, time = 1500 } )
			audio.stop( 1 )    -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ
		end

	end	


end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop(1)  -- НАСТРОИТЬ ОТКЛЮЧЕНИЕ МУЗЫКИ
	
	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end

	print("это фаза destroy")

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
