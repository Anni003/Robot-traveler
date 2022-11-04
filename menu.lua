local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"
local bgMusic
local playBtn



local function onPlayBtnRelease()
	composer.gotoScene( "scenes.platformer", "fade", 400 )
	return true	-- indicates successful touch
end

print("musicGlobal до фаз" )
print(musicGlobal )
print("musicGlobal до фаз" )




function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( "background.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "logo.png", 200, 32 )
	titleLogo.x = display.contentCenterX - 150
	titleLogo.y = 40
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton {
		label = "Играть",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "button.png",
		overFile = "button-over.png",
		width = 154, height = 40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentCenterX - 205
	playBtn.y = display.contentHeight - 60
	



	onOffText = display.newText( {
		fontSize = 24,
		text = "Звук выкл/вкл"
	})

	onOffText.x = display.contentCenterX - 200
	onOffText.y = display.contentHeight - 230
	onOffText:setFillColor( 0, 0.5, 1 )

	local onOffSwitch = widget.newSwitch(
		{
			style = "onOff",
			id = "onOffSwitch",
			onPress = function( event )
				local switch = event.target
				print( "Switch with ID is on: "..tostring(switch.isOn) )

				if (tostring(switch.isOn) == "false") then
					audio.stop()  -- Stop all audio
					musicGlobal = false
					print( "switch" )
					print( musicGlobal )
					print( "switch" )
				else 
					timer.performWithDelay( 10, function()
						audio.play( bgMusic, { loops = -1, channel = 2 } )
						musicGlobal = true
						print( "switch" )
						print( musicGlobal )
						print( "switch" )
					end)	
					
				end

			end
		}
	)
	onOffSwitch.x = display.contentCenterX - 90
	onOffSwitch.y = display.contentHeight - 230


	local textHowPlay = widget.newButton{
		label = "как играть?",
		fontSize = 24,
		labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
		defaultFile = "bbb.jpeg",
		overFile = "snd2.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("howPlay", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	textHowPlay.x = display.contentCenterX - 180
	textHowPlay.y = display.contentHeight - 180



	local aboutGameBtn = widget.newButton{
		label = "об авторах",
		fontSize = 24,
		labelColor = { default={ 0, 0.5, 1 }, over={ 0, 0.5, 1 } },
		defaultFile = "bbb.jpeg",
		overFile = "snd2.png",
		width = 200, height = 50,
		onPress = function(event)
			composer.showOverlay("abGame", {
				isModal = true,
				effect = "fade",
				time = 400,
			})
		end
	}
	
	aboutGameBtn.x = display.contentCenterX - 180
	aboutGameBtn.y = display.contentHeight - 120


	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( onOffText )
	sceneGroup:insert( onOffSwitch )
	sceneGroup:insert( textHowPlay )
	sceneGroup:insert( aboutGameBtn )
	sceneGroup:insert( playBtn )
end




function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if musicGlobal == true then
		bgMusic = audio.loadStream( "menu/menu-bg.mp3" )
	end
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		print("это фаза show")
		print(musicGlobal)
		print("это фаза show")

		if musicGlobal == true then
			timer.performWithDelay( 10, function()
				audio.play( bgMusic, { loops = -1, channel = 2 } )
				audio.fade({ channel = 1, time = 333, volume = 1.0 } )

			end)
			print("это фаза show. заход в функцию с вкл звука был")	
			print(musicGlobal)
			print("это фаза show. заход в функцию с вкл звука был")	
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
			audio.stop()  -- Stop all audio
		end
		print("это фаза hide")
		print(musicGlobal)
		print("это фаза hide")
	end	


end

function scene:destroy( event )
	local sceneGroup = self.view
	
	audio.stop()  -- Stop all audio
	audio.dispose( bgMusic )  -- Release music handle

	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
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
