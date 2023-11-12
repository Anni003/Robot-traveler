ThoseMenuBtn = widget.newButton {
	defaultFile = "menu-folder/images-for-menu/burger-menu.png",
	overFile = "menu-folder/images-for-menu/burger-menu-over.png",
	width = 80, height = 62,
	onRelease = goT0MenuBtn	-- event listener function
}
MyMenubtn = widget.newButton({
	label = "",
	--font = "fonts/geometria_medium",
	labelColor = { default={ 0.0 }, over={ 0.0 } },
	defaultFile = "img/menu.png",
	overFile = "img/menu.png",
	width = 200, height = 200,
	x = display.viewableContentWidth-100,
	y = 150,
	fontSize = 18,
	onRelease=function(event)
		composer.gotoScene( "menu", "fade", 400 )
	end	
}) 
	