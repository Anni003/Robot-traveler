display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

musicGlobal = true --глобальная проверка того, можно ли включать музыку! true - музыку можно

editVolume = false -- индикатор изменения громкости. false - музыка не была изменена

if (editVolume == false) then
    volumeGlobalMusic = 0.1 -- начальная громкость музыки
end

composer.gotoScene( "menu" )
-- composer.gotoScene( "scenes.reg" )