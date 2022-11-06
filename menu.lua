local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local playBtn

bgMusic = audio.loadStream( "menu/menu-bg.mp3" ) -- ПОДГРУЗКА МУЗЫКИ
audio.reserveChannels( 1 )

audio.setVolume( volumeGlobalMusic, { channel=1 } ) -- Громкость звука

local function onPlayBtnRelease()
	composer.gotoScene( "scenes.platformer", "fade", 400 )
	return true	-- indicates successful touch
end

      
function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "background.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	

	playBtn = widget.newButton {
		label = "Играть",
		fontSize = 35,
		font = "geometria_bold",
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "background.png",
		overFile = "background.png",
		width = 154, height = 40,
		onRelease = onPlayBtnRelease
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentHeight - 270


	local onOffMusic = display.newText( "музыка выкл/вкл", 65, 120, "geometria_medium", 20 )
    onOffMusic:setFillColor( 0, 0, 0 )


	local onOffZvuk = display.newText( "звук выкл/вкл", 50, 180, "geometria_medium", 20 )
    onOffZvuk:setFillColor( 0, 0, 0 )


	onOffMusicSwitch = widget.newSwitch(
		{
			style = "onOff",
			id = "onOffSwitch",
			onPress = function( event )
				local switch = event.target

				print( "Switch with ID is on: "..tostring(switch.isOn) )

				if (tostring(switch.isOn) == "false") then
					audio.stop( 1 )  -- Stop all audio
-- ЗДЕСЬ СДЕЛАТЬ ОТКЛЮЧЕНИЕ ТОЛЬКО АУДИОДОРОЖКИ МУЗЫКИ

					musicGlobal = false
				else 
					timer.performWithDelay( 10, function()
						audio.play( bgMusic, { loops = -1, channel = 1 } )
						musicGlobal = true
					end)	
					
				end

			end
		}
	)
	onOffMusicSwitch.x = display.contentCenterX - 30
	onOffMusicSwitch.y = display.contentHeight - 200


	local onOffZvukSwitch = widget.newSwitch(
		{
			style = "onOff",
			id = "onOffSwitch",
			onPress = function( event )
				local switch = event.target

				print( "Switch with ID is on: "..tostring(switch.isOn) )

				if (tostring(switch.isOn) == "false") then
					audio.stop( 1 )  -- Stop all audio
					-- ЗДЕСЬ СДЕЛАТЬ ОТКЛЮЧЕНИЕ ТОЛЬКО АУДИОДОРОЖКИ ЗВУКА
					zvukGlobal = false
				else 
					timer.performWithDelay( 10, function()
						audio.play( bgMusic, { loops = -1, channel = 1 } )
						zvukGlobal = true
					end)	
					
				end

			end
		}
	)
	onOffZvukSwitch.x = display.contentCenterX - 30
	onOffZvukSwitch.y = display.contentHeight - 140


	local settingsBtn = widget.newButton{
		label = "Настройки",
		font = "geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "background.png",
		overFile = "background.png",
		width = 154, height = 40,
		onPress = function(event)
			composer.showOverlay("settingsModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	settingsBtn.x = display.contentCenterX - 180
	settingsBtn.y = display.contentCenterY + 85


	local referenceBtn = widget.newButton{
		label = "Cправка",
		font = "geometria_medium",
		fontSize = 30,
		labelColor = { default={ 0.0 }, over={ 0.0 } },
		defaultFile = "background.png",
		overFile = "background.png",
		width = 154, height = 40,
		onPress = function(event)
			composer.showOverlay("referenceModal", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	referenceBtn.x = display.contentCenterX + 180
	referenceBtn.y = display.contentCenterY + 85


	sceneGroup:insert( background )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( onOffZvuk )
	sceneGroup:insert( onOffMusic )
	sceneGroup:insert( onOffZvukSwitch )
	sceneGroup:insert( onOffMusicSwitch )
	sceneGroup:insert( settingsBtn )
	sceneGroup:insert( referenceBtn )
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
