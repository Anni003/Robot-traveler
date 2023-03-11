local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local playBtn

bgMusic = audio.loadStream( "menu-folder/music/menu-bg.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )

audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука

local function onPlayBtnRelease()
	composer.gotoScene( "scenes.three_doors", "fade", 400 )
	return true	-- indicates successful touch
end

      
function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "menu-folder/images-for-menu/background.jpg", display.actualContentWidth, display.actualContentHeight )
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
		width = 460, height = 120,
		onRelease = onPlayBtnRelease
	}
	playBtn.x = display.contentCenterX - 390
	playBtn.y = display.contentCenterY - 80




--НОВЫЕ КНОПКИ ДЛЯ ЗВУКА И МУЗЫКИ -----------------------------------------

local switchMusic = true
local switchZvuk = true

	onOffMusicSwitch = widget.newButton {
		label = "",
		fontSize = 35,
		font = "fonts/geometria_bold",
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/music-on.png",
		overFile = "menu-folder/images-for-menu/music-off.png",
		width = 70, height = 70,
		onPress = function( event )

			if (switchMusic == true) then
				switchMusic = false
				audio.stop( 1 )  -- Stop all audio
	-- ЗДЕСЬ СДЕЛАТЬ ОТКЛЮЧЕНИЕ ТОЛЬКО АУДИОДОРОЖКИ МУЗЫКИ
				musicoff.alpha = 1
				musicGlobal = false
			else 
				switchMusic = true
				timer.performWithDelay( 10, function()
					audio.play( bgMusic, { loops = -1, channel = 1 } )
					musicGlobal = true
					musicoff.alpha = 0
				end)
				
			end

		end
		
	}
	onOffMusicSwitch.x = display.contentCenterX - 450
	onOffMusicSwitch.y = display.contentHeight - 90

	musicoff = display.newImageRect( "menu-folder/images-for-menu/music-off.png", 70, 70 )
		musicoff.alpha = 0

	
	musicoff.x = display.contentCenterX - 450
	musicoff.y = display.contentHeight - 90




	
	onOffZvukSwitch = widget.newButton { 
		label = "",
		fontSize = 35,
		font = "fonts/geometria_bold",
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/zvuk-on.png",
		overFile = "menu-folder/images-for-menu/zvuk-on.png",
		width = 70, height = 70,
		onPress = function( event )
			
			if (switchZvuk == true) then
				switchZvuk = false
				audio.stop( 1 )  -- Stop all audio
				-- ЗДЕСЬ СДЕЛАТЬ ОТКЛЮЧЕНИЕ ТОЛЬКО АУДИОДОРОЖКИ ЗВУКА
				zvukGlobal = false
				zvukoff.alpha = 1
			else 
				switchZvuk = true
				timer.performWithDelay( 10, function()
					audio.play( bgMusic, { loops = -1, channel = 1 } )
					zvukGlobal = true
					zvukoff.alpha = 0
				end)	
				
			end

		end
	}
	onOffZvukSwitch.x = display.contentCenterX - 320
	onOffZvukSwitch.y = display.contentHeight - 90


	zvukoff = display.newImageRect( "menu-folder/images-for-menu/zvuk-off.png", 70, 70 )
	zvukoff.alpha = 0

	zvukoff.x = display.contentCenterX - 320
	zvukoff.y = display.contentHeight - 90


----------------------------------------------------------------------------




	local settingsBtn = widget.newButton{
		label = "",
		font = "fonts/geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/settings.png",
		overFile = "menu-folder/images-for-menu/settings.png",
		width = 400, height = 100,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.settingsModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	settingsBtn.x = display.contentCenterX - 390
	settingsBtn.y = display.contentCenterY + 70





	local referenceBtn = widget.newButton{
		label = "",
		font = "fonts/geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "menu-folder/images-for-menu/reference.png",
		overFile = "menu-folder/images-for-menu/reference.png",
		width = 400, height = 100,
		onPress = function(event)
			composer.showOverlay("menu-folder.modalComponent.referenceModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	referenceBtn.x = display.contentCenterX - 390
	referenceBtn.y = display.contentCenterY + 190


	sceneGroup:insert( background )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( onOffZvukSwitch )
	sceneGroup:insert( onOffMusicSwitch )
	sceneGroup:insert( settingsBtn )
	sceneGroup:insert( referenceBtn )
	sceneGroup:insert( musicoff )
	sceneGroup:insert( zvukoff )
end




function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if musicGlobal == true then

	end
	if phase == "will" then

	elseif phase == "did" then

		print("это фаза show")

		if musicGlobal == true then
			timer.performWithDelay( 5, function()
				audio.play( bgMusic, { loops = -1, channel = 1 } ) -- НАСТРОЙКИ ПРОИГРЫВАТЕЛЯ
				-- audio.fade({ channel = 1, time = 100, volume = 0.1 } )

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
