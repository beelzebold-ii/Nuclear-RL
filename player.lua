--player and control related functions

function playerwait()
	if playerWeapon~=nil then
		playerturnend(6 * (playerWeapon.dmgtype=="melee" and pBonus.meleewaittimefactor or 1.0))
		else
		playerturnend(6)
		end
	if pObj.pain<2 and waitturns>0 then
		if pObj.damage>pObj.injuries + 6 then
			--randomly block the wait regen if injuries are high
			--100% chance at maxdamage injuries, scaling linearly
			if pObj.injuries <= 2 or love.math.random() > pObj.injuries/pObj.maxdamage then
				pObj.damage = pObj.damage - 2
				end
			end
		end
	if waitturns<5 then
		waitturns = waitturns + 1
		end
	fireturns = 0
	end

function playermove(key)
	waitturns = 0
	fireturns = math.max(0,fireturns-1)
	local movevec = {[config.keybinds.KEY_LEFT] = {-1,0},[config.keybinds.KEY_RIGHT] = {1,0},[config.keybinds.KEY_UP] = {0,-1},[config.keybinds.KEY_DOWN] = {0,1}}
	local newplayerpos = {x = pObj.pox+movevec[key][1],y = pObj.poy+movevec[key][2]}
	if (tilemap[newplayerpos.y][newplayerpos.x] == 0 or tilemap[newplayerpos.y][newplayerpos.x] == 2) and objat(newplayerpos.x,newplayerpos.y,eObjs) == -1 then
		pObj.pox = newplayerpos.x
		pObj.poy = newplayerpos.y
		local armormovetime = 1.0
		if playerArmor~=nil then
			armormovetime = playerArmor.movetime
			end
		playerturnend((pObj.movetime*armormovetime)*((100 - pObj.pain)/100),nil,true)
		end
	end
function cursormove(key)
	local movevec = {[config.keybinds.KEY_LEFT] = {-1,0},[config.keybinds.KEY_RIGHT] = {1,0},[config.keybinds.KEY_UP] = {0,-1},[config.keybinds.KEY_DOWN] = {0,1}}
	local newpos = {x = cursorx+movevec[key][1],y = cursory+movevec[key][2]}
	if distance(newpos.x,newpos.y,pObj.pox,pObj.poy)<=pObj.viewdist then
		cursorx = newpos.x
		cursory = newpos.y
		end
	hitscanlines = {}
	hitscanpoints = {}
	hitscan(pObj.pox,pObj.poy,cursorx,cursory)
	end

function playeraim(alt)
	if playerWeapon==nil then
		mkHudmessage("I'm gonna need a gun...")
		return
		end
	
	controlmode = M_FIRING
	altfiring = alt
	cursorx = pObj.pox
	cursory = pObj.poy
	
	local closestenemy = -1
	local closestdist = pObj.viewdist + 0.1
	for i,o in ipairs(eObjs) do
		local rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,o.id)
		local los = true
		if rayhit.type ~= "obj" or rayhit.hit ~= o then
			rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,0,true,nil)
			if rayhit.type ~= "none" then
				los = false
				end
			end
		if los==true and o.health>0 then
			local odist = distance(pObj.pox,pObj.poy,o.pox,o.poy)
			if odist<closestdist then
				closestenemy = i
				closestdist = odist
				end
			end
		end
	if closestenemy~=-1 then
		cursorx = eObjs[closestenemy].pox
		cursory = eObjs[closestenemy].poy
		end
	
	if alt==true then
		mkHudmessage("Firing (Altfire) - Select target or press escape")
		else
		mkHudmessage("Firing - Select target or press escape")
		end
	end

function playerattack()
	if playerWeapon.ammotype=="no" or playerWeapon.ammo>=(playerWeapon.ammouse==nil and 1 or playerWeapon.ammouse) then
		if cursorx==pObj.pox and cursory==pObj.poy then
			mkHudmessage("That's me, you idiot!")
			controlmode = M_MOVE
			return
			end
		waitturns = math.max(waitturns - 0.5,0)
		if playerWeapon.weaptype=="rapid" then
			fireturns = fireturns + 1
			end
		for i=1,playerWeapon.ammouse==nil and 1 or playerWeapon.ammouse do
			if pBonus.freefifthshot==true then
				shots = shots + 1
				if shots%5 == 0 then
					shots = 0
					else
					if playerWeapon.ammotype~="no" then playerWeapon.ammo = playerWeapon.ammo-1 end
					end
				else
				if playerWeapon.ammotype~="no" then playerWeapon.ammo = playerWeapon.ammo-1 end
				end
			end
		sfx[playerWeapon.sound]:stop()
		sfx[playerWeapon.sound]:play()
		for i=1,playerWeapon.shots==nil and 1 or playerWeapon.shots do
			if playerWeapon.dmgtype~="spread" then
				if playerWeapon.dmgtype~="melee" then
					--bullet
					print("PLAYER ATTACK:")
					local rayhit = hitscan(pObj.pox,pObj.poy,cursorx,cursory)
					if rayhit.type~="obj" then
						mkHudmessage("The shot hits nothing.",{1,0.6,0.1,1})
						else
						local o = rayhit.hit
						local dist = distance(pObj.pox,pObj.poy,o.pox,o.poy)
						local tohit = playerWeapon.tohit * pObj.tohit * ((100 - pObj.pain)/100)
						for i=1,math.ceil(dist) do
							tohit = tohit*0.95
							end
						--if we've been aiming, gain 0.1 (by aim factor) tohit per turn waited
						tohit = tohit + pObj.tohitbonus + (math.min(waitturns,3)*(0.1*pBonus.aimfactor))
						if fireturns>1 then
							--if we're rapidfiring for over 1 shot, lose 0.2 (by recoil factor) tohit per shot
							--veteran has an innate 0.7 recoil factor
							tohit = tohit * (1 - (fireturns-1)*((0.2*pBonus.rpdrecoilfactor)*(playerClass==4 and 0.7 or 1.0)))
							end
						
						print("Target distance: "..dist)
						print("Base ToHit: "..playerWeapon.tohit)
						print("Hit chance: "..tohit)
						
						if love.math.random()<tohit then
							makeFlrObj(".",{0.3,0,0,1},o.pox+love.math.random(-1,1),o.poy+love.math.random(-1,1))
							local damage = 0
							local pistolminbuff = 0
							--if we should apply sidearmory's minimum damage buff, we apply it by evenly distributing the buff among the dice's minimum rolls
							--the damage is rounded up after all of that is finished, so hopefully no problems will arise.
							if playerWeapon.weaptype=="sidearm" then
								pistolminbuff = pBonus.sidearmdmgmin/playerWeapon.dice
								end
							for i=1,playerWeapon.dice do
								damage = damage + love.math.random(1+pistolminbuff,playerWeapon.sides)
								end
							if dist>pObj.pointblank then
								damage = damage - (dist - pObj.pointblank) * 0.5
								damage = math.max(damage,playerWeapon.dice/2)
								end
							
							--if we're aimed and have an aim dmg bonus to apply, apply it fully once for 2 turns of waiting (so at max of 3 waitturns it'd be 1.5x)
							if waitturns>0 and pBonus.aimdmg>0 then
								damage = damage + pBonus.aimdmg * (math.min(waitturns,3)/2)
								end
							
							damage = math.ceil(damage)
							--if we're in rapidfire and the damage debuff should apply, lose 1 damage per shot in the volley!
							if pBonus.rpddmgdebuff==true and fireturns>1 then damage = math.max(damage - (fireturns - 1),0) end
							--innate bonus damage
							damage = damage + pObj.damagebonus
							--and lastly, sidearm only bonus damage
							if playerWeapon.weaptype=="sidearm" then
								damage = damage + pBonus.sidearmdmgbuff
								end
							mkHudmessage("The "..o.name.." is hit for "..damage.." damage!",{0.2,1,0.2,1})
							o.health = o.health-damage
							o.chasing = true
							if o.health<=0 then
								mkHudmessage(o.deathmsg,{0.5,1.0,0.5,1})
								killObj(o.id)
								end
							else
							mkHudmessage("The shot missed the "..o.name..".",{0.2,1,0.2,1})
							end
						end
					else
					--melee
					waitturns = 0
					local rayhit = hitscan(pObj.pox,pObj.poy,cursorx,cursory)
					if rayhit.type~="obj" then
						mkHudmessage("The swing hits nothing.")
						else
						local o = rayhit.hit
						local dist = distance(pObj.pox,pObj.poy,o.pox,o.poy)
						if dist>1.6 then
							mkHudmessage("The swing hits nothing.")
							else
							local tohit = playerWeapon.tohit * ((120 - pObj.pain)/120)
							if waitturns>1 then tohit = tohit + 0.1 end
							if love.math.random()<tohit then
								makeFlrObj(".",{0.3,0,0,1},o.pox+love.math.random(-1,1),o.poy+love.math.random(-1,1))
								local damage = 0
								for i=1,playerWeapon.dice do
									damage = damage + love.math.random(1,playerWeapon.sides)
									--officer does guaranteed bonus damage equal to the weapon's damage dice
									--veteran gets on average half that
									if playerClass==1 or (playerClass==4 and love.math.random()<0.5) then damage = damage + 1 end
									end
								--deal additional damage from waitturns based on weapon's charge bonus stat
								if waitturns>0 then damage = damage + playerWeapon.chrgbonus[math.floor(math.min(waitturns,3))] end
								--every point of vitality = a 20% chance to deal extra damage, as officer every lvl = additional 10% chance
								if (pStats.vit+(playerClass==1 and pObj.lv/2 or 0))/5>love.math.random() then
									--bonus is 2 damage plus 1 for every 2 vitality and 1 for every 4 lvls if playing as officer
									damage = damage + 2 + ((pStats.vit+(playerClass==1 and pObj.lv/2 or 0))/2) + pBonus.meleecritbuff
									end
								
								damage = math.floor(damage)
								mkHudmessage("The "..o.name.." is struck for "..damage.." damage!",{0.2,1,0.2,1})
								o.health = o.health-damage
								o.chasing = true
								if o.health<=0 then
									mkHudmessage(o.deathmsg,{0.5,1.0,0.5,1})
									killObj(o.id)
									if pBonus.meleelifesteal==true then
										pObj.damage = math.max(pObj.damage-love.math.random(3,6),0)
										end
									end
								else
								mkHudmessage("The strike missed the "..o.name..".",{0.2,1,0.2,1})
								end
							end
						end
					end
				else
				--spread
				local cursordist = distance(pObj.pox,pObj.poy,cursorx,cursory)
				local targetx = ((cursorx-pObj.pox)/cursordist)*(playerWeapon.range+pBonus.shotchokebuff)+pObj.pox - 1
				local targety = ((cursory-pObj.poy)/cursordist)*(playerWeapon.range+pBonus.shotchokebuff)+pObj.poy - 1
				local hits = 0
				local totaldmg = 0
				local killmsg
				for i=0,8 do
					local rayhit = hitscan(pObj.pox,pObj.poy,targetx+(i%3),targety+math.floor(i/3))
					
					if rayhit.type=="obj" then
						local o = rayhit.hit
						local dist = distance(pObj.pox,pObj.poy,o.pox,o.poy)
						local tohit = playerWeapon.tohit*pBonus.shottohit
						--if we've been aiming, gain 0.1 (by aim factor) tohit per turn waited (max 1 instead of 3)
						tohit = tohit + pObj.tohitbonus + (math.min(waitturns,1)*(0.1*pBonus.aimfactor))
						--freelancer gets 0.1 extra base tohit with shotguns
						if playerClass==3 then tohit = tohit + 0.1 end
						
						if fireturns>1 then
							--if we're rapidfiring for over 1 shot, lose 0.2 (by recoil factor) tohit per shot
							tohit = tohit * (1 - (fireturns-1)*(0.2*pBonus.rpdrecoilfactor))
							end
						for i=1,math.ceil(dist) do
							--accuracy falloff is 7.5% per tile instead of 5%
							tohit = tohit*0.925
							end
						--tohit multiplier applies 10% less
						tohit = (tohit + pObj.tohitbonus) * (pObj.tohit * 0.9)
						
						if love.math.random()<tohit then
							makeFlrObj(".",{0.3,0,0,1},o.pox+love.math.random(-2,2),o.poy+love.math.random(-2,2))
							hits = hits + 1
							local damage = 0
							--if we should apply sidearmory's minimum damage buff, we apply it by evenly distributing the buff among the dice's minimum rolls
							--the damage is rounded up after all of that is finished, so hopefully no problems will arise.
							local pistolminbuff = 0
							if playerWeapon.weaptype=="sidearm" then
								pistolminbuff = pBonus.sidearmdmgmin/playerWeapon.dice
								end
							for i=1,playerWeapon.dice do
								damage = damage + love.math.random(1+pistolminbuff,playerWeapon.sides)
								end
							if dist>pObj.pointblank then
								damage = damage - (dist - pObj.pointblank) * 0.5
								damage = math.max(damage,playerWeapon.dice/2)
								damage = math.ceil(damage)
								end
							--damagebonus per pellet is cut to 1/6
							if love.math.random()<1/6 then
								damage = damage + pObj.damagebonus
								end
							--so is sidearm damage buff for the sawnoff, but to 1/7
							if love.math.random()<1/7 then
								if playerWeapon.weaptype=="sidearm" then
									damage = damage + pBonus.sidearmdmgbuff
									end
								end
							totaldmg = totaldmg + damage
							o.health = o.health-damage
							o.chasing = true
							if o.health<=0 then
								killmsg = o.deathmsg
								killObj(o.id)
								end
							end
						end
					end
				
				if hits<1 then
					mkHudmessage("The shot hits nothing.",{1,0.6,0.1,1})
					else
					mkHudmessage(hits.." pellets hit for "..totaldmg.." total damage!",{0.2,1,0.2,1})
					if killmsg~=nil then mkHudmessage(killmsg,{0.5,1.0,0.5,1}) end
					end
				end
			end
		
		local atktime = 1.0
		if playerWeapon.weaptype ~= "rapid" then
			atktime = pObj.atktimesemi
			end
		if playerWeapon.weaptype == "shotgun" then
			atktime = pObj.atktimepump
			end
			
		playerturnend(playerWeapon.atktime*atktime+love.math.random(-1,1),true)
		else
		mkHudmessage("Gun's empty!",{1.0,0.4,0.2,1})
		controlmode = M_MOVE
		end
	end

function tryplayerreload()
	if playerAmmo["a"..playerWeapon.ammotype]<1 then
		mkHudmessage("No more ammo!",{1.0,0.4,0.2,1})
		else
		local reloadamt = math.min(playerAmmo["a"..playerWeapon.ammotype],playerWeapon.maxammo-playerWeapon.ammo)
		playerAmmo["a"..playerWeapon.ammotype] = playerAmmo["a"..playerWeapon.ammotype] - reloadamt
		playerWeapon.ammo = playerWeapon.ammo + reloadamt
		
		waitturns = 0
		
		local shotgunbonusspd = 1.0
		if playerWeapon.dmgtype=="spread" then shotgunbonusspd = pBonus.shotreload end
		
		--detective reloads 20% faster
		local detectivebonusspd = 1.0
		if playerClass==2 then detectivebonusspd = 0.80 end
		
		playerturnend((playerWeapon.reltime*pObj.reltime+love.math.random(-1,1)) * shotgunbonusspd * detectivebonusspd)
		end
	end

function playerusepainkiller(o)
	if o==nil then return end
	if o.type~="pain" then return end
	
	local usetime = 8
	if pObj.pain > 5 then
		usetime = usetime + (pObj.pain / 5)
		end
	
	local healamt = love.math.random(o.minheal,o.maxheal)
	--using painkillers to heal pain is a bit wasteful compared to damage as pain isn't quite as important to clear fast
	healamt = math.max(healamt - math.floor((pObj.pain * 0.5)),1)
	pObj.pain = 0 --however, even if the item didn't have enough heal to get to your health damage, all pain is cleared anyway 
	
	if healamt > 1 then
		if pObj.damage > pObj.maxdamage then --heal bonus when overdamaged
			healamt = healamt + math.floor((healamt/5) + (pObj.maxdamage/6))
			end
		pObj.damage = math.max(math.floor(pObj.damage - healamt), 0)
		else
		if pObj.damage > pObj.maxdamage then --if no heal due to pain still heal some bonus if overdamaged
			healamt = math.floor((pObj.maxdamage/6))
			pObj.damage = math.max(math.floor(pObj.damage - healamt), 0)
			end
		end
	
	--importantly, time is taken *after* the item is used
	mkHudmessage("Used "..o.name.." to heal "..healamt.." damage.",{0.2,1,0.2,1})
	playerturnend(usetime,true)
	end
function playerusefirstaid(o)
	if o==nil then return end
	if o.type~="aid" then return end
	
	local usetime = o.usetime + (pObj.pain / 3)
	
	pObj.pain = math.floor( pObj.pain + ( o.pain * (1.0 + love.math.random()) ) )
	
	pObj.injuries = math.max(pObj.injuries - o.heal, 0)
	
	--importantly, time is taken *after* the item is used
	mkHudmessage("Used "..o.name.." to heal "..o.heal.." injuries.",{0.2,1,0.2,1})
	playerturnend(usetime,true)
	end


function playerLvUp()
	pObj.xp = 0
	pObj.lv = pObj.lv + 1
	pObj.sp = pObj.sp + 1
	
	pObj.maxdamage = pObj.maxdamage + 3
	pObj.tohit = pObj.tohit + 0.1
	pObj.painfactor = pObj.painfactor * 0.95
	
	gamestate = STATE_LVUP
	menuselect = 1
	
	local classlvup = {
		function() --officer - gets slightly tankier
			pObj.maxdamage = pObj.maxdamage + 2
			pObj.painfactor = pObj.painfactor * 0.95
			end,
		function() --detective - gets quite more accurate
			pObj.tohit = pObj.tohit + 0.05
			pObj.tohitbonus = pObj.tohitbonus + 0.05
			pObj.pointblank = pObj.pointblank + 0.5
			if pObj.lv%2==0 then
				pObj.damagebonus = pObj.damagebonus + 1
				end
			end,
		function() --freelancer - gets slightly faster
			pObj.movetime = math.max(pObj.movetime * 0.95,5)
			pObj.atktimepump = math.max(pObj.atktimepump * 0.95,0.5)
			pObj.reltime = math.max(pObj.reltime * 0.95,0.35)
			end,
		function() --war vet - gets nothing lmao
			
			end
	}
	end

function damageplayer(dmg,noarmor,dist)
	dmg = dmg * ( 0.9 + (pObj.injuries*0.02) )
	makeFlrObj(".",{0.3,0,0,1},pObj.pox+love.math.random(-1,1),pObj.poy+love.math.random(-1,1))
	
	if gameskill>1 then dmg = dmg*1.05 + 0.5 end
	if gameskill>3 then dmg = dmg + 1 end
	local pain = (dmg * 1.1 + 1) * pObj.painfactor
	if gameskill>2 then pain = pain + 1 end
	if gameskill>3 then pain = pain + (dmg * 0.4) end
	if playerArmor~=nil and noarmor~=true then
		local dmgfactor = 1.0
		for i=1,playerArmor.protection do
			dmgfactor = dmgfactor*0.85
			end
		
		pain = pain * playerArmor.painfactor
		local originaldmg = dmg
		dmg = dmg * dmgfactor
		--armor takes as much damage as it *saves* you from plus some change
		playerArmor.durability = playerArmor.durability - math.floor((originaldmg-dmg) * 1.2 + 1)
		
		if playerArmor.durability<1 then playerArmor=nil end
		end
	
	--if bleedblock > 50 then it's been a fair enough time since the player was last shot and so we will graciously reduce
	--the amount of injuries on this hit
	
	--guaranteed injuries
	--skills 1 and 2 have 1/6 injuries, 3 and 4 have 1/4 injuries
	local guaranteedinjuryrate = (gameskill > 2 and 4 or 6)
	--rounded, not floored, cos armor makes many attacks outright less than 4 damage
	local injuries = math.floor((dmg / guaranteedinjuryrate) + 0.5)
	--bleedblock stops up to two guaranteed injuries (one on goin nuclear)
	if pObj.bleedblock > 50 then
		injuries = math.max(0,injuries - (gameskill > 3 and 1 or 2))
		end
	--random injuries
	--unchanged by gameskill
	local randominjuryrolls = math.floor(dmg/4)
	--bleedblock reduces random injury rolls by normally zero, but the more guaranteed injuries got through,
	--the more random injuries it will block.
	--one extra random injury blocked for every two guaranteed injuries past the limit from before
	if pObj.bleedblock > 50 then
		randominjuryrolls = randominjuryrolls - math.floor(injuries / 2)
		end
	for i=1,randominjuryrolls do --every fourth point of damage rolls for an aditional wound
		if i>randominjuryrolls then break end
		--the base chance for this to succeed is 33%, every point of damage adds an additional 2%
		if love.math.random()<(0.33 + dmg/50) then
			injuries = injuries + 1
			end
		end
	if noarmor~=true then
		pObj.injuries = pObj.injuries + math.max(injuries,0)
		end
	
	if dist~=nil and dist<3 then
		local bonusdmg = 3.5-dist
		dmg = dmg + math.floor(bonusdmg*0.4)
		pain = pain + math.ceil(bonusdmg*2.5)
		end
	
	pObj.damage = pObj.damage + dmg
	mkHudmessage("I'm hit for "..math.floor(dmg+0.5).." damage!",{1.0,0.2,0.2,1})
	--if pain shouldn't be outright blocked, apply it
	if (pBonus.dodgeshield==false or playerDodge==false) and (pBonus.aimshield==false or waitturns==0) then
		print("Applied "..pain.."% pain")
		pObj.pain = pObj.pain + pain
		else
		print("Pain blocked")
		--print("dodgeshield: "..pBonus.dodgeshield)
		--print("playerDodge: "..playerDodge)
		--print("aimshield:   "..pBonus.aimshield)
		--print("waitturns:   "..waitturns)
		end
	
	pObj.bleedblock = 0
	
	if pObj.damage + pObj.pain/10 > pObj.maxdamage then
		--scale 0..1 representing how much overdamage the player has after this attack
		local overdamage = (pObj.damage - pObj.maxdamage)/pObj.maxdamage
		--scale 0..1 representing how much of the player's damage threshold this attack is worth
		local thisdmg = dmg/pObj.maxdamage
		
		if overdamage + (thisdmg/2) > love.math.random() then
			--you die!
			print(playerName.." has died!")
			print("Total runtime: "..runtime/10 .."s")
			print("Kills: "..kills.."/"..enemies)
			playerDead = true
			local xdeath = 0
			if overdamage<0.4 then
				mkHudmessage("I've hit the ground...")
				else
				if overdamage>0.7 then
					mkHudmessage("It all fades to black.")
					xdeath = 2
					else
					mkHudmessage("My knees buckle beneath me!")
					xdeath = 1
					end
				end
			pscore = pscore/1.1
			--perfect killrate?
			if kills >= enemies - localenemycount and levelnum > 1 then pscore = math.floor(pscore*1.2) end
			--score based on avg time spent per floor
			local avgtime = (runtime/levelnum) / 3600 --1.0 at 6 mins per floor, 2.0 at 12 mins, 0.5 at 3 mins
			avgtime = math.min(avgtime,1.5) --time taken penalty can only go as high as 1.5; this equates to 9 mins
			avgtime = math.max(avgtime,0.5) --time taken penalty can only go as low as 0.5, or 3 mins (double score)
			--this means you get extra score for going faster than 6 mins per floor
			--but you get penalized for going slower than that
			--3 mins = 200% score, 12 mins = 50% score, 9 mins would be 66% score, 5 mins would be 120% score
			pscore = pscore / avgtime
			mortisinfo = {runtime=runtime,enemies=enemies,kills=kills,score=math.floor(pscore*(gameskill*0.5 + 0.5)),level=pObj.lv,floor=levelnum,class=playerClass,skill=gameskill,pname=playerName,skillsorder=pSkillOrder,stats=pStats,victory=false,xdeath=xdeath}
			saveMsglog("deathlog_"..os.date("%m.%d.%Y").."-"..playerName)
			mkHudmessage(hudmessage.." Press enter.")
			end
		end
	end

function generateMortem(info)
	local mtxt = ""
	local xdeathtxt = {"unconscious","dead","mangled"}
	local diffname = {"easy","normal","hard","hardest"}
	
	if info.victory==false then
		--failure report
		mtxt="Incident Report:\n \n"
		mtxt=mtxt.."Subject: "..info.pname.." (lv"..info.level.." "..pclassnameshort[info.class]..")\n"
		mtxt=mtxt.."Found "..xdeathtxt[info.xdeath+1].." on floor "..info.floor.." of Nuclear R&D.\n"
		mtxt=mtxt.."Nuclear Version: "..gameversion.."\n \n"
		if cheatermode==true then
			mtxt=mtxt.."Cheats were used during this run.\n \n"
			end
		
		local firefights = "and then a series of firefights broke out shortly thereafter."
		if love.math.random()<0.4 and info.floor<=1 then
			firefights = "then immediately began attacking security staff."
			end
		local killratio = math.min(1,info.kills/(info.enemies-localenemycount))
		if info.floor==1 then killratio = 0.5 end
		if killratio>0.85 then
			firefights = "and proceeded to wreak indescriminate havoc on everyone they saw."
			if love.math.random()<0.4 then
				firefights = "killing or otherwise incapacitating most or all of the security staff they encountered."
				end
			else
			if killratio<0.3 and love.math.random()<0.7 then
				firefights = "and attempted to infiltrate the building, killing several security contractors."
				end
			end
		if info.kills<=3 then
			if info.floor<2 then
				firefights = "and proceeded to get gunned down immediately after opening fire."
				if love.math.random()<0.6 then
					firefights = "and was promptly killed."
					if love.math.random()<0.5 then
						firefights = "opened fire on the security staff,and was swiftly taken care of."
						end
					end
				else
				firefights = "and snuck through the facility unnoticed before being dispatched."
				if love.math.random()<0.5 then
					firefights = "and was only spotted well into their infiltration, before being engaged."
					end
				end
			end
		if info.skill>2 and killratio>0.8 and info.floor>4 and love.math.random()<0.7 then
			firefights = "impossibly overwhelming the security force."
			end
		if info.floor>6 and love.math.random()<0.8 then
			firefights = "and caused trouble throughout much of the facility, making it over halfway to the bottom floor."
			if love.math.random()<0.5 then
				firefights = "and then engaged in many firefights on their way deep into the facility."
				end
			if killratio>0.8 and love.math.random()<0.65 then
				firefights = "killing a great amount of the total security force before being stopped."
				end
			end
		if info.runtime/info.floor<1800 and info.floor>3 then --less than 3 min per floor and floor 4 or higher
			if love.math.random()<0.9 then
				firefights = "and very swiftly made their way through the facility before being stopped."
				end
			if killratio>0.6 and love.math.random()<0.8 then
				firefights = "and very swiftly made their way through the facility, killing plenty of guards along their way."
				end
			end
		if killratio>0.97 then --can only miss 1 guard per 34 spawned in order to get the YAAM
			firefights = firefights.." They hunted everyone down like a maniac."
			if love.math.random()<0.3 then
				firefights = "and killed as many security guards as they could, in a horrific bloodbath."
				end
			if love.math.random()<0.07 then
				firefights = firefights.." Yet another asskicking marine, I guess."
				end
			end
		mtxt=mtxt.."Subject entered the building around 1900 hrs, "..firefights.." Motive presumed to be related to the recently failed legal case against Nuclear.\n"
		mtxt=mtxt.."Subject was neutralized approx. "..timerText(info.runtime/10).." later.\n \n"
		
		mtxt=mtxt.."Confirmed casualties: "..info.kills.." (personnel, drones, canines)\n"
		mtxt=mtxt.."Estimated survivors: "..info.enemies-info.kills.."\n \n"
		
		mtxt=mtxt.."Difficulty: "..skillnames[info.skill].." ("..diffname[info.skill]..")\n"
		mtxt=mtxt.."Score: "..info.score.."\n \n"
		
		mtxt=mtxt.."Stats:\nSpd: "..info.stats.spd.."\nAcc: "..info.stats.acc.."\nVit: "..info.stats.vit.."\nPer: "..info.stats.per.."\n \n"
		
		mtxt=mtxt.."Skills taken: \n"
		local thisline=0
		for k,skl in ipairs(info.skillsorder) do
			if thisline>3 then mtxt=mtxt.."\n";thisline=0 end
			thisline=thisline+1
			mtxt=mtxt..skl
			if k<#info.skillsorder then mtxt=mtxt..", " end
			end
		else
		--victory report
		mtxt="Severe Incident Report:\n \n"
		end
	
	return mtxt
	end
