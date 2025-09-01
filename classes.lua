objclasses={
	pissecguard = {
		char="S",
		color={0,0.6,0.9,1},
		health=25,
		atksound="pistol",
		dice=3,
		sides=4,
		tohit=0.9,
		shots=1,
		xp=10,
		movetime=12,
		cooldown=1,
		aggro=0.8,
		range=9,
		name="Security Guard",
		desc="Simple security guard. Unarmored, lightly armed, and fortunately quite dumb.",
		deathmsg="The Security Guard collapses.",
		ammo="9mm",ammocount=12,drops={"m99pis","m99pis","secarm"}
	},
	shotsecguard = {
		char="S",
		color={0,0.6,0.9,1},
		health=25,
		atksound="batrifle",
		dice=3,
		sides=4,
		tohit=0.65,
		shots=3,
		xp=15,
		movetime=12,
		cooldown=2,
		aggro=0.8,
		range=8,
		name="Security Guard",
		desc="Simple security guard. Unarmored, lightly armed, and fortunately quite dumb.",
		deathmsg="The Security Guard collapses.",
		ammo="12ga",ammocount=4,drops={"sawnoff","sawnoff","secarm"}
	},
	secdog = {
		char="s",
		color={0,0.6,0.9,1},
		health=10,
		dice=4,
		sides=4,
		tohit=0.8,
		shots=1,
		xp=8,
		movetime=6,
		cooldown=2,
		aggro=1,
		range=1,
		name="Security Dog",
		desc="Aww, a doggy! Too bad it'll maul you to death if you let it. Sorry boy, you gotta go.",
		deathmsg="The Security Dog falls to its side."
	},
	smgtacguard = {
		char="R",
		color={0.6,0.6,0.6,1},
		health=50,
		atksound="submachine",
		dice=3,
		sides=4,
		tohit=0.6,
		shots=3,
		xp=20,
		movetime=11,
		cooldown=1,
		aggro=0.70,
		range=10,
		name="Riot Guard",
		desc="A riot guard, in riot guard armor. Wields some decent weaponry. Kill him and take it.",
		deathmsg="The Riot Guard drops to the ground.",
		ammo="9mm",ammocount=30,drops={"sm40smg","sm40smg","riotarm","secarm"}
	},
	rifletacguard = {
		char="R",
		color={0.6,0.6,0.6,1},
		health=50,
		atksound="rifle",
		dice=5,
		sides=4,
		tohit=0.8,
		shots=1,
		xp=23,
		movetime=11,
		cooldown=1,
		aggro=0.65,
		range=10,
		name="Riot Guard",
		desc="A riot guard, in riot guard armor. Wields some decent weaponry. Kill him and take it.",
		deathmsg="The Riot Guard drops to the ground.",
		ammo="5mm",ammocount=15,drops={"sn730rifle","riotarm","secarm"}
	},
	riflemilguard = {
		char="M",
		color={0,0.5,0,1},
		health=90,
		atksound="rifle",
		dice=5,
		sides=4,
		tohit=0.9,
		shots=2,
		xp=33,
		movetime=9,
		cooldown=1,
		aggro=0.8,
		range=10,
		name="Militia Guard",
		desc="This highly trained soldier will gladly show you to your grave. Armored, armed, and scary. Kill on sight.",
		deathmsg="The Militia Guard hits the ground.",
		ammo="5mm",ammocount=17,drops={"sn730rifle","sn730rifle","milarm","riotarm"}
	},
	shotmilguard = {
		char="M",
		color={0,0.5,0,1},
		health=90,
		atksound="batrifle",
		dice=4,
		sides=4,
		tohit=0.85,
		shots=3,
		xp=34,
		movetime=9,
		cooldown=2,
		aggro=0.7,
		range=9,
		name="Militia Guard",
		desc="This highly trained soldier will gladly show you to your grave. Armored, armed, and scary. Kill on sight.",
		deathmsg="The Militia Guard hits the ground.",
		ammo="12ga",ammocount=6,drops={"ca12shotty","ca12shotty","milarm","riotarm"}
	},
	mildog = {
		char="m",
		color={0,0.5,0,1},
		health=40,
		dice=5,
		sides=5,
		tohit=0.9,
		shots=1,
		xp=19,
		movetime=5,
		cooldown=2,
		aggro=1,
		range=1,
		name="Militia Dog",
		desc="Puppy! Yeah, no. Better get to firing, cos you're not outrunning this pupper.",
		deathmsg="The Militia Dog falls to its side."
	},
	gundrone = {
		char="D",
		color={0.4,0.4,0.4,1},
		health=50,
		atksound="rifle",
		dice=4,
		sides=5,
		tohit=0.8,
		shots=3,
		xp=30,
		movetime=6,
		cooldown=2,
		aggro=0.85,
		range=8,
		fly=true,
		name="Gun Drone",
		desc="Uh uh. Bad news. You need to take care of this thing before it takes care of you.",
		deathmsg="The Gun Drone hits the ground with a satisfying crack."
	},
	shockdrone = {
		char="d",
		color={0.4,0.4,0.4,1},
		health=50,
		dice=6,
		sides=6,
		tohit=1.0,
		shots=1,
		xp=25,
		movetime=4,
		cooldown=0,
		aggro=1,
		range=1.45,
		fly=true,
		name="Shock Drone",
		desc="It's fast, armored, and it has a taser. It's a taser attack drone. Who came up with this?",
		deathmsg="The Shock Drone falls from the sky, still buzzing its taser."
	},
	protogunbot = {
		char="B",
		color={0.4,0.5,0.8,1},
		health=120,
		atksound="submachine",
		dice=3,
		sides=4,
		tohit=0.85,
		shots=3,
		xp=150,
		movetime=10,
		cooldown=0,
		aggro=0.75,
		range=9,
		name="Defense Bot",
		desc="It appears to be a quadrupedal robot with a submachinegun bolted to it. It isn't running out of ammo any time soon either.",
		deathmsg="The Defense Bot is destroyed! I hope to never see another."
	},
	gunbot = {
		char="B",
		color={0.5,1,0.6,1},
		atksound="rifle",
		health=180,
		dice=5,
		sides=5,
		tohit=0.9,
		shots=3,
		xp=220,
		movetime=9,
		cooldown=0,
		aggro=0.7,
		range=10,
		name="Defense Bot",
		desc="I guess the last one was a prototype. This one has a rifle instead of a submachinegun! Frabjous day.",
		deathmsg="The Defense Bot falls! That better be the last one."
	},
	eliteguard = {
		char="E",
		color={1,1,1,1},
		health=180,
		atksound="rifle",
		dice=5,
		sides=5,
		tohit=1.1,
		shots=2,
		xp=51,
		movetime=7,
		cooldown=1,
		aggro=0.7,
		range=11,
		name="Elite Guard",
		desc="These guys are guarding the thing you came here for. Unfortunate.",
		deathmsg="The Elite Guard breaths its last breath.",
		ammo="5mm",ammocount=22,drops={"sn730rifle","sn730rifle","milarm","milarm","balarm"}
	}
}
function makeObj(classname,ox,oy)
	local o={pox=ox,poy=oy}
	local c=objclasses[classname]
	if c==nil then print("invalid object classname!");return end
	o.char=c.char--the character representing the obj
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
	if gameskill>3 then o.health = o.health * 1.15 end
	o.maxhealth=o.health
	
	table.insert(eObjs,o)
	
	enemies = enemies + 1
	end
function makeFlrObj(char,color,ox,oy)
	print("made flr obj")
	local foat = objat(ox,oy,fObjs)
	if foat~=-1 then
		fObjs[foat].char = char
		fObjs[foat].color = color
		return
		end
	local o={pox=ox,poy=oy}
	o.char=char
	o.color=color
	o.id=#fObjs+1
	table.insert(fObjs,o)
	end
function killObj(oid)
	local o = eObjs[oid]
	pscore = pscore + (o.xp*3) + pObj.pain + 16
	if gameskill==1 then o.xp = math.floor(o.xp*0.5) else
		if gameskill==2 then o.xp = math.floor(o.xp*0.75) end
		end
	pObj.xp = pObj.xp + o.xp
	if pObj.xp>=pObj.lv*70-20 then
		playerLvUp()
		end
	makeFlrObj("%",{o.color[1]*0.4,o.color[2]*0.4,o.color[3]*0.4,o.color[4]},o.pox,o.poy)
	if (love.math.random()<0.7 or gameskill<3) and o.ammo~=nil then
		if love.math.random()<0.7 then
			--drop ammo
			local amt = love.math.random(2,o.ammocount)
			makeAmmoObj(o.ammo,amt,o.pox,o.poy)
			else
			--drop a random item
			local drop = o.drops[love.math.random(1,#o.drops)]
			local maxcounts = {
				m99pis = 12,
				sawnoff = 2,
				sm40smg = 30,
				ca12shotty = 6,
				sn730rifle = 30,
				secarm = 70,
				riotarm = 70,
				milarm = 100,
				balarm = 150
			}
			makeItemObj(drop,love.math.random(1,maxcounts[drop]),o.pox,o.poy)
			end
		end
	
	kills = kills + 1
	localenemycount = localenemycount - 1
	if localenemycount == 0 then
		pscore = pscore + 30
		hudmessage = "With the "..o.name.."'s death, all is peaceful."
		end
	--eObjs[oid]=nil
	end