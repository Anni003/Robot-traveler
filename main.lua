display.setStatusBar( display.HiddenStatusBar )

time_1 = 0
time_2 = 0
time_3 = 0

local composer = require "composer"

musicGlobal = true --глобальная проверка того, можно ли включать музыку! true - музыку можно

editVolume = false -- индикатор изменения громкости. false - музыка не была изменена

if (editVolume == false) then
    volumeGlobalMusic = 1 -- начальная громкость музыки
end

native.setProperty("windowMode", "fullscreen")
 
composer.gotoScene( "scenes.hidden_object" )
