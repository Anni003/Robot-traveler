-- Include the Composer library
local composer = require("composer")

-- Removes status bar
display.setStatusBar(display.HiddenStatusBar)

-- Removes bottom bar on Android
if system.getInfo("androidApiLevel") and system.getInfo("androidApiLevel") < 19 then
	native.setProperty("androidSystemUiVisibility", "lowProfile")
else
	native.setProperty("androidSystemUiVisibility", "immersiveSticky")
end

-- Platform detection
local isSimulator = "simulator" == system.getInfo("environment")
local isMobile = ("ios" == system.getInfo("platform")) or ("android" == system.getInfo("platform"))

-- Go to platformer screen
composer.gotoScene("scenes.platformer")
-- composer.gotoScene("scenes.menu")
