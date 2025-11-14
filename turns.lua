--turn machine stuff
local Vector = require( "luafinding/vector" )
local Luafinding = require("luafinding/luafinding")

function playerturnend(timetaken,noclear,moving)
	if moving==true and love.math.random()<0.7*(1+pBonus.activedodgerate) then playerDodge = true else playerDodge = false end
	timetaken=math.floor(timetaken+0.5)
	lasttimetaken = timetaken/10
	lastturnframes = frames
	
	if pObj.pain==0 and pObj.damage > pObj.injuries then
		--regen speed halved when at maxdamage injuries
		local timeToRegen = math.floor(10 + 10*(pObj.injuries/pObj.maxdamage))
		if timetaken<=timeToRegen then
			pObj.regentime = pObj.regentime + timetaken
			else
			pObj.damage = math.max(pObj.injuries, pObj.damage - math.floor(timetaken/timeToRegen))
			pObj.regentime = pObj.regentime + (timetaken%timeToRegen)
			end
		print("regen time "..pObj.regentime)
		if pObj.regentime>=timeToRegen then
			pObj.damage = math.max(pObj.injuries, pObj.damage - 1)
			pObj.regentime = pObj.regentime - timeToRegen
			end
		else
		pObj.pain = math.floor(math.max(0, pObj.pain * pObj.painfactor - math.floor(timetaken/2)))
		end
	
	if noclear~=true then
		hudmessage = ""
		controlmode = M_MOVE
		gamestate = STATE_GAME
		end
	
	if tilemap[pObj.poy][pObj.pox]==2 then
		damageplayer(timetaken/3,true)--3.33 damage per second standing in acid
		pObj.pain = pObj.pain + love.math.random(-1,6)
		end
	
	print("Passing time ("..timetaken/10 .."s)")
	
	runtime = runtime + timetaken
	
	--record the current board state into the replay buffer
	--THIS IS GOING TO BE A NIGHTMARE!!!
	--assigning tables to new variables in lua only assigns the POINTER TO THE TABLE! IT DOES NOT CREATE A NEW TABLE!
	--this is NOT GOOD FOR THIS SCENARIO because I want to SAVE THE EXISTING INFORMATION FOR LATER!!!
	--I have decided that INSTEAD!!! I will be keeping a screenshot of every turn!!!
	takescreenshot = true
	--this will be deferred to the drawing code because 1. I think it has to and 2. to ensure all
	--changes this turn have been made already
	
	for _,o in ipairs(eObjs) do
		o.justfired = false
		end
	for i=1,timetaken do
		foreach(eObjs,eobjTick)
		end
	hitscanlines = {}
	hitscanpoints = {}
	if controlmode==M_FIRING then
		hitscan(pObj.pox,pObj.poy,cursorx,cursory)
		end
	
	if pObj.pox==exit.pox and pObj.poy==exit.poy then
		mkHudmessage("Press enter to descend to the next level")
		end
	local iat = objat(pObj.pox,pObj.poy,iObjs)
	if iat~=-1 and hudmessage=="" then
		mkHudmessage("Press "..config.keybinds.KEY_GET.." to get "..iObjs[iat].item.name)
		end
	
	update = true
	end

function eobjTick(o)
	if o.health<1 then return end
	
	o.turncounter = o.turncounter + 1
	if o.turncounter>=o.movetime then
		o.turncounter = love.math.random(0,1)
		--it's my turn!
		local dist = distance(o.pox,o.poy,pObj.pox,pObj.poy)
		local rayhit = hitscan(pObj.pox,pObj.poy,o.pox,o.poy)
		
		if o.chasing==true then
			local canattack = false
			if love.math.random()<o.aggro and dist<o.range+1 and o.attacksteps<1 then canattack = true end
			local hasLOS = false
			if rayhit.hit==o then hasLOS = true end
			
			if ((not canattack) or (not hasLOS)) and dist>love.math.random(1.2,1.4) then
				--better get a better position.
				print(o.name.." at ("..o.pox..","..o.poy..") is moving")
				
				ignoreobj = o
				local pathmap = makepathmap(o.fly)
				local path = Luafinding( Vector(o.pox,o.poy), Vector(pObj.pox,pObj.poy), pathmap):GetPath()
				
				if path==nil or #path<2 then
					print("no path...")
					else
					o.pox = path[2].x
					o.poy = path[2].y
					end
				
				o.attacksteps = o.attacksteps - 1
				else
				--engaging target.
				print(o.name.." at ("..o.pox..","..o.poy..") is attacking")
				o.justfired = true
				
				if sfx[o.atksound]~=nil then
					sfx[o.atksound]:stop()
					sfx[o.atksound]:play()
					end
				
				for i=1,o.shots do
					local tohit = o.tohit - (((pStats.spd + 3) * 0.02) + pBonus.passivedodgerate)
					if gameskill > 1 then tohit = tohit + 0.1 end
					
					for i=1,math.ceil(dist) do
						tohit = tohit*0.95
						end
					
					if gameskill > 3 then tohit = tohit + 0.1 end
					
					--if the player dodged then heavy debuff to chance to hit
					if playerDodge==true then
						tohit = tohit - (pBonus.activedodgerate + 0.2)
						end
					
					if love.math.random()<tohit then
						local damage = 0
						for i=1,o.dice do
							damage = damage + love.math.random(1,o.sides)
							end
						if dist>2 then
							damage = damage - math.floor((dist-2)/1.5)
							end
						local dmgdist = dist
						if o.range<1.9 then dmgdist = nil end
						mkHudmessage("The "..o.name.." attacks!",{1.0,0.2,0.2,1})
						damageplayer(damage,false,dmgdist)
						else
						if playerDodge==true and playerDead==false then
							mkHudmessage("Dodged!")
							if pBonus.dodgeshield==true then
								waitturns = waitturns+1
								end
							end
						end
					end
				
				o.attacksteps = o.cooldown
				end
			else
			--while idle
			if dist<11 and rayhit.hit==o then
				o.chasing = true
				end
			end
		end
	end


--replay gif stuffs
function createReplayGif()
	local rpgif = gifcat.newGif("r_nuclearrl-replay_"..playerName.."_"..os.date("%m.%d.%Y").."_"..runtime..".gif",800,480,15)
	for k,v in ipairs(replayBuffer) do
		local durscale = 1.0
		if k==#replayBuffer then
			durscale = 5.0
			end
		rpgif:frame(v[1],(v[2]/1.5)*durscale,"scale",false)
		end
	rpgif:close()
	end