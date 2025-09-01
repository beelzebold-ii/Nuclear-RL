sfx = {
	pistol = love.audio.newSource("sounds/pistol.wav","static"),
	submachine = love.audio.newSource("sounds/submachine.wav","static"),
	rifle = love.audio.newSource("sounds/rifle.wav","static"),
	batrifle = love.audio.newSource("sounds/batrifle.wav","static"),
}

mus = {
	title = love.audio.newSource("music/HalfDeath.wav","stream"),
	death = love.audio.newSource("music/RadiationIncident.wav","stream"),
}

mus.title:setLooping(true)
mus.death:setLooping(true)

function updateVol()
	for k,v in pairs(mus) do
		v:setVolume(config.mus/15)
		end
	for k,v in pairs(sfx) do
		v:setVolume(config.sfx/15)
		end
	end