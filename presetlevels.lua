--data for preset levels

presetlevels = {
	[4] = {
		{
			name = "Security Checkpoint",
			filename = "checkpoint.json",
			entrytext = "Entering the checkpoint. High security, what hospitality.",
			calmtext = "All is calm. But my documents were all in order!",
			music = love.audio.newSource("music/Meltdown.wav","stream"),
		},
	},
	[8] = {
		{
			name = "Waste Refinery Center",
			filename = "refinery.json",
			entrytext = "Entering the refinery. Do I have to go down there?",
			calmtext = "All is calm. Now I gotta go before my lungs collapse.",
			music = love.audio.newSource("music/LongWar.wav","stream"),
		},
		{
			name = "Barricade",
			entrytext = "Some kind of barricade. It seems they were waiting for me.",
			calmtext = "All is calm. What a nightmare.",
			music = love.audio.newSource("music/LongWar.wav","stream"),
		},
	},
	[12] = {
		{
			name = "Medical Room",
			entrytext = "Entering the medical room. I sense a certain tension.",
			calmtext = "All is calm. The scent of viscera is overwhelming.",
			music = love.audio.newSource("music/LongWar.wav","stream"),
		},
		{
			name = "High Security Vault",
			entrytext = "Entering the vault. It's like a fortress down here.",
			calmtext = "All is calm. Now what kind of loot did you leave me?",
			music = love.audio.newSource("music/LongWar.wav","stream"),
		},
		{
			name = "Main Lab",
			entrytext = "Entering the main lab. What's that sound...? Uh oh.",
			calmtext = "All is calm. Now where can I lay down to die in peace?",
			music = love.audio.newSource("music/LongWar.wav","stream"),
		},
	},
}