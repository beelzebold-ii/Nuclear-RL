--return{
	--modinfo string is required for all mods
	modinfo = "Test level containing all sidearms.",
	
	clearlevels = true,
	
	presetlevels = {
		{
			floor = 1,
			name = "Pistols",
			filename = "test/all pistols.json",
			entrytext = "Entering.",
			calmtext = "All is calm.",
			music = love.audio.newSource("music/Meltdown.wav","stream"),
		},
	},
}