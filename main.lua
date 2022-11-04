-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
musicGlobal = true --глобальная проверка того, можно ли включать музыку! true - музыку можно
composer.gotoScene( "menu" )
