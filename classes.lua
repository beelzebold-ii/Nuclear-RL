-- NOTE: THESE ARE NOW UNUSED DATA!!!

objclasses={
	pissecguard = {
	},
	shotsecguard = {
	},
	secdog = {
	},
	smgtacguard = {
	},
	rifletacguard = {
	},
	riflemilguard = {
	},
	shotmilguard = {
	},
	mildog = {
	},
	gundrone = {
	},
	shockdrone = {
	},
	gundronesmall = {
	},
	shockdronesmall = {
	},
	turret1 = {
	},
	turret2 = {
	},
	protogunbot = {
	},
	gunbot = {
	},
	eliteguard = {
	}
}
function makeObj(classname,ox,oy)
	local o={pox=ox,poy=oy}
	local c=objclasses[classname]
	if c==nil then print("invalid object classname!");mkHudmessage("invalid object classname!");return end
	o.char=c.char--the character representing the obj
	if c.graphic==nil then
		print(classname.." graphic nil")
		end
	o.graphic=c.graphic--the graphical icon for the obj
	o.color=c.color--the color of said char
	o.health=c.health
	o.atksound=c.atksound--sound made when the obj attacks
	o.dice=c.dice--number of dice in the obj's attack
	o.sides=c.sides--sides per die
	o.tohit=c.tohit--chance to hit (point blank)
	o.shots=c.shots--number of shots per attack
	o.xp=c.xp--xp awarded on kill
	o.movetime=c.movetime--how many turns of the player's for every one of the obj's turns
	o.turncounter=love.math.random(0,1)--how many turns since the obj's last turn, for counting the above
	o.attacksteps=1--how many steps the obj must take before attacking
	o.cooldown=c.cooldown--what to reset attacksteps to after an attack
	o.aggro=c.aggro--the chance (0 to 1.0) for the obj to attack if it can
	o.range=c.range--attack range of the enemy
	o.fly=c.fly--if fly is true they move freely over acid
	o.nomoving=c.nomoving--self explanatory, object cannot move
	o.name=c.name--displayed on the info screen and when hovered
	o.desc=c.desc--same as above
	o.deathmsg=c.deathmsg--message displayed when you kill the object
	o.chasing=false--if false the object will roam aimlessly. set to true if the object can see the player.
	--drops
	o.ammo=c.ammo
	o.ammocount=c.ammocount
	o.drops=c.drops
	o.id=#eObjs+1
	
	if gameskill>2 then o.health = (o.health + 1) * 1.1 end
	if gameskill>3 then o.health = o.health * 1.1 end
	o.maxhealth=o.health
	
	table.insert(eObjs,o)
	
	enemies = enemies + 1
	end
function makeFlrObj(char,graphic,color,ox,oy)
	print("made flr obj")
	local foat = objat(ox,oy,fObjs)
	if foat~=-1 then
		fObjs[foat].char = char
		fObjs[foat].graphic = graphic
		fObjs[foat].color = color
		return
		end
	local o={pox=ox,poy=oy}
	o.char=char
	o.graphic=graphic
	o.color=color
	o.id=#fObjs+1
	table.insert(fObjs,o)
	end
function killObj(oid)
	local o = eObjs[oid]
	pscore = (pscore + (o.xp*3) - pObj.pain) + 16
	if gameskill==1 then o.xp = math.floor(o.xp*0.8) else
		if gameskill==2 then o.xp = math.floor(o.xp*0.9) end
		end
	pObj.xp = pObj.xp + o.xp
	if pObj.xp>=pObj.lv*70-20 then
		playerLvUp()
		end
	makeFlrObj("%","corpse",{o.color[1]*0.4,o.color[2]*0.4,o.color[3]*0.4,o.color[4]},o.pox,o.poy)
	if (love.math.random()<0.7 or gameskill<3) and o.ammo~=nil then
		if love.math.random()<0.7 then
			--drop ammo
			local amt = love.math.random(2,o.ammocount)
			makeAmmoObj(o.ammo,amt,o.pox,o.poy)
			else
			--drop a random item
			if o.drops~=nil then
				local drop = o.drops[love.math.random(1,#o.drops)]
				local maxcounts = {
					m99pis = 12,
					sawnoff = 2,
					sm40smg = 30,
					ca12shotty = 6,
					sn730rifle = 30,
					secarm = 60,
					riotarm = 70,
					milarm = 100,
					balarm = 150
				}
				makeItemObj(drop,love.math.random(1,maxcounts[drop]),o.pox,o.poy)
				end
			end
		end
	
	kills = kills + 1
	localenemycount = localenemycount - 1
	if localenemycount == 0 then
		pscore = pscore + 50
		mkHudmessage("With the "..o.name.."'s death, all is peaceful.",{0.2,0.2,1.0,1.0})
		end
	--eObjs[oid]=nil
	end