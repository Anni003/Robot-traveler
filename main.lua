-- Include the libraries
local composer = require("composer")

-- Removes the status bar on most devices
display.setStatusBar(display.HiddenStatusBar)

-- Go to next scene
composer.gotoScene("scenes.maze", { })