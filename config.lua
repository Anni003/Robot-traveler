--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 1152,
		height = 1920, 
		scale = "letterbox",
		fps = 100,
		xAlign = "center",  
		yAlign = "center",  
		
		[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		]]
	},
}
