sfx = {
	pistol = love.audio.newSource("sounds/pistol.wav","static"),
	submachine = love.audio.newSource("sounds/submachine.wav","static"),
	rifle = love.audio.newSource("sounds/rifle.wav","static"),
	batrifle = love.audio.newSource("sounds/batrifle.wav","static"),
	melee = love.audio.newSource("sounds/pistol.wav","static"),
}

mus = {
	title = love.audio.newSource("music/HalfDeath.wav","stream"),
	death = love.audio.newSource("music/RadiationIncident.wav","stream"),
}
lvmus = {
	cluster1 = {--floors 1-3
		love.audio.newSource("music/DangerClose.wav","stream"),
		love.audio.newSource("music/Unnatural.wav","stream"),
		love.audio.newSource("music/Meltdown.wav","stream"),
	},
	cluster2 = {--floors 4-6
		love.audio.newSource("music/ArmsRace.wav","stream"),
		love.audio.newSource("music/BulletDance.wav","stream"),
		love.audio.newSource("music/CorporateMilitary.wav","stream"),--this is primarily a cluster3 song
	},
	cluster3 = {--floors 7-9
		love.audio.newSource("music/CorporateMilitary.wav","stream"),
	}
}

mus.title:setLooping(true)
mus.death:setLooping(true)
for k,v in pairs(lvmus) do
	for k2,v2 in ipairs(v) do
		v2:setLooping(true)
		end
	end

function updateVol()
	for k,v in pairs(mus) do
		v:setVolume(config.mus/15)
		end
	for k,v in pairs(lvmus) do
		for k2,v2 in ipairs(v) do
			v2:setVolume(config.mus/17)
			end
		end
	for k,v in pairs(sfx) do
		v:setVolume(config.sfx/15)
		end
	end
