-- drawing stuffs when in actual gameplay states
-- most of the stuff directly in this function is hud/menu stuff I believe

--   TODOs:

-- leave everything used by the main menu completely untouched. not opening that can of worms, it works fine.
-- separate tile and hud/menu drawing into their own canvases
--   ^ (will these allow transparency or will I have to go fucking insane trying to force them to overlay right?)

-- rewrite the blur shader passes to work in UV instead of strict resolution requirements, it was shitty anyway
--   ^ (pull from the shadertoy blur passes I made for PDVR?)
-- make new shader pass canvases which will constantly update to the window's resolution.
-- rewrite the shader passes to work in the window's actual resolution, with scaling done independently for tile/hud

-- detect graphical mode and use a larger size for the tile drawing canvas in it (scale accordingly)

-- this is all a lot so I think I'm gonna start tearing relevant shit apart and rewriting.

require("drawworld")

function updatescreen(camx,camy)
	local ttt = love.timer.getTime()
	
	love.graphics.setCanvas(tilecanvas)
	love.graphics.clear(0,0,0,1)
	drawworld(camx,camy)
	drawObjs(camx,camy)
	--message
	love.graphics.setColor(1,1,1)
	love.graphics.print(hudmessage,65,2)
	
	if gamestate==STATE_MORE then
		love.graphics.setColor(0,0,0,0.65)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print(eObjs[moreobj].name,200,105)
		
		love.graphics.printf(eObjs[moreobj].desc.."\n \nDAMAGE: "..eObjs[moreobj].dice.."d"..eObjs[moreobj].sides.." x"..eObjs[moreobj].shots.."\nTO HIT: "..eObjs[moreobj].tohit,185,135,450)
		end
	if gamestate==STATE_LVUP then
		love.graphics.setColor(0,0,0,0.65)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("LEVEL UP!",135,90)
		love.graphics.print("PICK A STAT TO UPGRADE",120,105)
		
		local statnames = {" SPEED"," ACCURACY"," VITALITY"," PERCEPTION"}
		local statids = {"spd","acc","vit","per"}
		for i=1,4 do
			love.graphics.setColor(1,0.2,0.2)
			if menuselect==i then love.graphics.setColor(0.2,1,0.2) end
			love.graphics.print("["..pStats[statids[i]].."]"..statnames[i],120,120+(i*15))
			end
		
		local statdesc = {
			"General increased dexterity and speed.\n \nDecreased movetime, atktime, and reloadtime. Enemies have decreased hit chance.",
			"More reliable shots.\n \nIncreased accuracy at closer range, and increased damage.",
			"More resiliant to damage.\n \nIncreased damage threshold, and pain affects you less. Melee crits are more likely and deal more damage.",
			"More capable at long range.\n \nSlightly increased accuracy at all ranges, increased view distance, and less damage falloff."
		}
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.printf(statdesc[menuselect],345,135,350)
		end
	if gamestate==STATE_TRAIT then
		love.graphics.setColor(0,0,0,0.65)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("LEVEL UP!",135,90)
		love.graphics.print("PICK A SKILL TO IMPROVE",120,105)
		love.graphics.print(pObj.sp.." SP remaining",120,120)
		
		local statnames = {" SIDEARMORY"," SUSTAINED FIRE"," STEADY AIM"," SHOTGUNNERY"," DODGEBALL"," TRACKING"," PACKRAT"," SLAYER"}
		local statids = {"side","rapid","marks","shot","dodge","track","pack","brute"}
		for i=1,8 do
			love.graphics.setColor(1,0.2,0.2)
			if pSkills[statids[i]]==3 then
				love.graphics.setColor(1,1,0.2)
				else
				if pSkills[statids[i]]<pObj.sp then
					love.graphics.setColor(1,0.2,0.2)
					else
					love.graphics.setColor(0.5,0.2,0.2)
					end
				end
			if menuselect==i then
				if pSkills[statids[i]]>1 then
					love.graphics.setColor(1,1,0.2)
					else
					love.graphics.setColor(0.2,1,0.2)
					end
				end
			if pSkills[statids[i]]==3 then
				love.graphics.print("[MAX]"..statnames[i],90,135+(i*15))
				else
				love.graphics.print("["..pSkills[statids[i]].."]"..statnames[i],90,135+(i*15))
				end
			end
		if menuselect==9 then
			love.graphics.setColor(0.2,1,0.2)
			else
			love.graphics.setColor(1,0.2,0.2)
			end
		love.graphics.print("DONE",90,285)
		
		local statdesc = {
			"\"Why have one if you don't use it?\"\n \nDraw sidearms faster, and increase minimum damage with them.",
			"\"All I believe in is more dakka.\"\n \nSuffer less inaccuracy from firing rapidfire weapons in large volleys.",
			"\"Take your time, there's no hurry!\"\n \nIncreases the benefits of waiting before firing.",
			"\"I just think they're neat.\"\n \nFire shotguns with slightly more accuracy, and reload them faster.",
			"\"Nobody can hit me, man!\"\n \nIncrease to both passive and active dodge rate.",
			"\"If you stay quiet, you can hear them moving...\"\n \nSee enemies from further, and hear them through walls a short distance.",
			"\"The humanity! My gun is out of bullets!\"\n \nCarry more ammo and items, and reload faster.",
			"\"For guts and motherfucking glory.\"\n \nDeal bonus melee crit damage, move and charge strikes faster when wielding a melee weapon."
		}
		local legendarybuff = {
			"Deal +2 damage with sidearms.",
			"No damage debuff from rapidfire volleys.",
			"Feel no pain while waiting still.",
			"All shotguns have tighter choke.",
			"Feel no pain while running, successful dodges aim for you automatically.",
			"See all enemies while waiting still.",
			"Get pickups instantly. Every third shot consumes no ammo.",
			"Heal slightly and gain Stim time on every melee kill."
		}
		if menuselect<9 then
			love.graphics.setColor(1,0.2,0.2)
			love.graphics.printf(statdesc[menuselect],345,135,350)
			if pSkills[statids[menuselect]]>1 then
				love.graphics.setColor(1,1,0.2)
				else
				love.graphics.setColor(0.4,0.3,0.1)
				end
			love.graphics.printf("Legendary: "..legendarybuff[menuselect],345,300,350)
			love.graphics.setColor(0.2,1,0.2)
			if pSkills[statids[menuselect]]+1>pObj.sp then love.graphics.setColor(1,0.2,0.2) end
			love.graphics.print("Cost: "..pSkills[statids[menuselect]]+1 .." SP",345,285)
			end
		end
	
	--player
	love.graphics.setColor(0.2,0.2,1)
	love.graphics.print(playerName,45,405)
	love.graphics.print(math.floor(pObj.damage/pObj.maxdamage*100).."% Damage ",45,420)
	local painandinjuries = ""
	if pObj.injuries > 0 then
		painandinjuries = painandinjuries.. pObj.injuries.." Wounds"
		end
	if pObj.pain > 0 and pObj.stim < 1 then
		if pObj.injuries > 0 then painandinjuries = painandinjuries.. " / " end
		painandinjuries = painandinjuries.. math.floor(pObj.pain+0.5).."% Pain"
		end
	love.graphics.setColor(0.5,0,0,1)
	if pObj.stim > 0 then
		if pObj.injuries > 0 then painandinjuries = painandinjuries.. " / " end
		painandinjuries = painandinjuries.. "("..pObj.stim / 10 .."s Stim)"
		love.graphics.setColor(0.3,0.8,0.3,1)
		end
	love.graphics.print(painandinjuries,45,450)
	love.graphics.setColor(0.2,0.2,1)
	if playerArmor==nil then
		love.graphics.print("NO ARMOR",45,435)
		else
		love.graphics.print(playerArmor.shortname.." ("..math.floor(playerArmor.durability/playerArmor.maxdurability*100).."%)",45,435)
		end
	love.graphics.print("Level "..pObj.lv.." "..pclassnameshort[playerClass].." ("..pObj.xp.."/"..pObj.lv*70-20 ..")",220,405)
	if playerWeapon==nil then
		love.graphics.print("Weapon: NONE",220,420)
		love.graphics.print("  Ammo: N/A",220,435)
		else
		love.graphics.print("Weapon: "..playerWeapon.name.." ("..playerWeapon.dice.."d"..playerWeapon.sides.. (playerWeapon.dmgtype=="spread" and "x9"..(playerWeapon.shots==nil and "" or "x"..playerWeapon.shots)..")" or (playerWeapon.shots==nil and "" or "x"..playerWeapon.shots)..")"),220,420)
		if playerWeapon.ammotype~="no" then
			love.graphics.print("  Ammo: "..playerWeapon.ammo.."/"..playerWeapon.maxammo.." ("..playerWeapon.ammotype..")",220,435)
			else
			love.graphics.print("  Ammo: N/A",220,435)
			end
		
		local aimnum = math.min(waitturns,3)
		local aimtxt = ""
		if waitturns > 0 then
			if playerWeapon.dmgtype=="spread" then
				aimnum = math.min(waitturns,1)
				end
			aimtxt = " Aim"
			if playerWeapon.dmgtype=="melee" then
				aimtxt = " Charge"
				end
			aimtxt = "+"..aimnum..aimtxt
			end
		if playerWeapon.weaptype=="rapid" and fireturns > 0 then
			if #aimtxt > 1 then aimtxt = aimtxt.." / " end
			aimtxt = aimtxt.."-"..fireturns.." Recoil"
			end
		love.graphics.setColor(0.3,0.8,0.3,1)
		if fireturns >= waitturns - 0.5 then
			love.graphics.setColor(0.5,0,0,1)
			end
		love.graphics.print(aimtxt,300,450)
		end
	--find targetted object
	love.graphics.setColor(1,0.2,0.2)
	local target = -1
	local targetItem = false
	local ray = checkLOS(pObj.pox,pObj.poy,cursorx,cursory,-2,true)
	if ray.type ~= "wall" or controlmode~=M_FIRING then
		if controlmode==M_FIRING then
			if objat(cursorx,cursory,eObjs)~=-1 then
				target = objat(cursorx,cursory,eObjs)
				else
				if objat(cursorx,cursory,iObjs)~=-1 then
					target = iObjs[objat(cursorx,cursory,iObjs)].item
					targetItem = true
					end
				end
			else
			if objat(pObj.pox,pObj.poy,iObjs)~=-1 then
				target = iObjs[objat(pObj.pox,pObj.poy,iObjs)].item
				targetItem = true
				end
			end
		end
	--actually draw target info
	if target~=-1 then
		if targetItem==false then
			love.graphics.print("Target: "..eObjs[target].name,555,405)
			love.graphics.print("Health: "..math.floor((eObjs[target].health/eObjs[target].maxhealth)*100).."%",570,420)
			love.graphics.print(" [m]ore",570,435)
			else
			love.graphics.print("Target:",555,405)
			love.graphics.print(target.name,570,420)
			if target.type=="ammo" then
				love.graphics.print("Count: "..target.amount,570,435)
				end
			if target.type=="weapon" then
				love.graphics.print("    ("..target.dice.."d"..target.sides.. (target.dmgtype=="spread" and "x9"..(target.shots==nil and "" or "x"..target.shots)..")" or (target.shots==nil and "" or "x"..target.shots)..")"),570,435)
				if target.ammotype~="no" then
					love.graphics.print("Ammo: "..target.ammo.."/"..target.maxammo,570,450)
					end
				end
			if target.type=="armor" then
				love.graphics.print("Durability: "..math.floor(target.durability/target.maxdurability*100).."%",570,435)
				end
			if target.type=="aid" then
				love.graphics.print("Uses left: "..target.uses.."/"..target.maxuses,570,435)
				end
			end
		else
		love.graphics.print("Target: NONE",555,405)
		end
	--time taken last turn
	if lasttimetaken~=nil then
		if frames-lastturnframes<3 then
			love.graphics.setColor(1,1,1,1)
			else
			love.graphics.setColor(0.2,0.2,1,(120-(frames-lastturnframes))/90)
			end
		love.graphics.print(lasttimetaken.."s",730,390)
		end
	
	if gamestate==STATE_INV then
		love.graphics.setColor(0,0,0,0.65)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("INVENTORY",150,60)
		for i,v in ipairs(playerInventory) do
			local xtratxt=""
			if v.type=="weapon" and v.ammotype~="no" then
				xtratxt = " ("..v.ammo.."/"..v.maxammo..")"
				end
			if v.type=="armor" then
				xtratxt = " ("..math.floor(v.durability/v.maxdurability*100).."%)"
				end
			if v.type=="aid" then
				xtratxt = " ("..v.uses.."/"..v.maxuses..") +"
				end
			
			if menuselect==i and ammoselect==false then
				love.graphics.setColor(0.2,1,0.2)
				end
			love.graphics.print(v.name..xtratxt,135,75+(i*15))
			love.graphics.setColor(1,0.2,0.2)
			end
		
		if ammoselect==false then
			love.graphics.print("AMMO",500,120)
			love.graphics.print("9mm  "..playerAmmo.a9mm,485,150)
			love.graphics.print(".35  "..playerAmmo["a.35"],485,165)
			love.graphics.print("5mm  "..playerAmmo.a5mm,485,180)
			love.graphics.print("7mm  "..playerAmmo.a7mm,485,195)
			love.graphics.print("12ga "..playerAmmo.a12ga,485,210)
			local ammobulk = (playerAmmo.a9mm*2) + (playerAmmo["a.35"]*2.5) + (playerAmmo.a5mm*2.5) + (playerAmmo.a7mm*3) + (playerAmmo.a12ga*4)
			love.graphics.print("CAPACITY",485,240)
			love.graphics.print(math.floor(ammobulk).."/"..200+pBonus.ammocapbuff,485,255)
			
			local itemsel = playerInventory[menuselect]
			if itemsel~=nil then
				love.graphics.print(itemsel.name,150,255)
				if itemsel.type=="weapon" then
					love.graphics.print("Damage: "..itemsel.dice.."d"..itemsel.sides.. (itemsel.dmgtype=="spread" and "x9"..(itemsel.shots==nil and "" or "x"..itemsel.shots) or (itemsel.shots==nil and "" or "x"..itemsel.shots)),135,285)
					love.graphics.print("To Hit: "..itemsel.tohit,135,300)
					if itemsel.dmgtype=="spread" then
						love.graphics.print("Choke:  "..itemsel.range-1,135,315)
						love.graphics.printf(itemsel.desc,135,345,500)
						else
						if itemsel.dmgtype=="melee" then
							local chargebar = string.sub("IIIII",1,itemsel.charge)
							love.graphics.print("Charge rating:  "..chargebar,135,315)
							love.graphics.printf(itemsel.desc,135,345,500)
							else
							love.graphics.printf(itemsel.desc,135,330,500)
							end
						end
					if itemsel.ammotype~="no" then
						love.graphics.print("Reload time: "..itemsel.reltime/10 .."s",315,285)
						else
						if itemsel.dmgtype=="melee" then
							love.graphics.print("Charge time: "..itemsel.chrgtime/10 .."s",315,285)
							else
							love.graphics.print("Reload time: N/A",315,285)
							end
						end
					love.graphics.print("Fire time:   "..itemsel.atktime/10 .."s",315,300)
					end
				if itemsel.type=="armor" then
					love.graphics.print("Protection: "..itemsel.protection,135,285)
					love.graphics.print("Durability: "..itemsel.maxdurability,135,300)
					love.graphics.print("Move time: +"..(itemsel.movetime*100)-100 .."%",315,285)
					love.graphics.printf(itemsel.desc,135,330,500)
					end
				if itemsel.type=="pain" then
					love.graphics.print("Avg heal: ".. (itemsel.minheal + itemsel.maxheal)/2,135,285)
					love.graphics.printf(itemsel.desc,135,330,500)
					end
				if itemsel.type=="aid" then
					love.graphics.print("Heals: ".. itemsel.heal,135,285)
					if itemsel.pain > 0 then
						love.graphics.print("Pain:  "..itemsel.pain.." - "..itemsel.pain*2,135,300)
						else
						love.graphics.print("Pain:  0",135,300)
						end
					love.graphics.print("Use time: "..math.floor(itemsel.usetime + (pObj.pain / 3)) / 10 .."s",315,285)
					love.graphics.printf(itemsel.desc,135,330,500)
					end
				end
			else
			local ammos = {"9mm  ",".35  ","5mm  ","7mm  ","12ga "}
			local ammoid = {"9mm",".35","5mm","7mm","12ga"}
			love.graphics.print("AMMO",500,120)
			for i=1,5 do
				if menuselect==i then
					love.graphics.setColor(0.2,1,0.2)
					end
				love.graphics.print(ammos[i]..playerAmmo["a"..ammoid[i]],485,135+(i*15))
				love.graphics.setColor(1,0.2,0.2)
				end
			local ammobulk = (playerAmmo.a9mm*2) + (playerAmmo["a.35"]*2.5) + (playerAmmo.a5mm*2.5) + (playerAmmo.a7mm*3) + (playerAmmo.a12ga*4)
			love.graphics.print("CAPACITY",485,240)
			love.graphics.print(math.floor(ammobulk).."/"..200+pBonus.ammocapbuff,485,255)
			
			local ammodesc = {
				"The classic small size round. Lightweight but punchy. Not great against armor though.",
				"Roughly the same bore as 9mm, much angrier round. Lucky day if you get to spend these bundles of magnum joy freely.",
				"The 5mm rifle round is an excellent intermediate size cartridge capable of hurting \"real men\" real bad.",
				"Everyone loves to get the chance to use a full size battle rifle round. Hefty, but worth the weight.",
				"Ah, the beloved 12-gauge buckshot. Cheap, effective, and long tried and tested. Though, not the lightest ammo.",
			}
			local ammoweight = {1,1.25,1.25,1.5,2}
			
			love.graphics.print(ammos[menuselect],150,255)
			love.graphics.print("Weight: "..ammoweight[menuselect],135,285)
			love.graphics.printf(ammodesc[menuselect],135,315,500)
			end
		end
	if gamestate==STATE_EQUIP then
		love.graphics.setColor(0,0,0,0.65)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("EQUIPMENT",150,60)
		love.graphics.print("STATS",500,100)
		if playerArmor==nil then
			love.graphics.print("Move time:   "..math.floor(pObj.movetime + 0.5)/10 .."s",485,135)
			else
			love.graphics.print("Move time:   "..math.floor(pObj.movetime * playerArmor.movetime + 0.5)/10 .."s",485,135)
			end
		if playerWeapon==nil then
			love.graphics.print("Fire time:   N/A",485,150)
			love.graphics.print("Reload time: N/A",485,165)
			else
			local atktime = 1.0
			if playerWeapon.weaptype ~= "rapid" then
				atktime = pObj.atktimesemi
				end
			if playerWeapon.weaptype == "shotgun" then
				atktime = pObj.atktimepump
				end
			love.graphics.print("Fire time:   "..math.floor(playerWeapon.atktime * atktime + 0.5)/10 .."s",485,150)
			if playerWeapon.ammotype~="no" then
				love.graphics.print("Reload time: "..math.floor(playerWeapon.reltime * pObj.reltime * pBonus.packreload + 0.5)/10 .."s",485,165)
				else
				love.graphics.print("Reload time: N/A",485,165)
				end
			end
		if (pObj.tohit-0.05)%1==0 then
			love.graphics.print("To Hit: "..pObj.tohit-0.05 ..".0x",485,195)
			else
			love.graphics.print("To Hit: "..pObj.tohit-0.05 .."x",485,195)
			end
		if (pObj.tohitbonus+(math.min(waitturns,3)*0.1))%1==0 then
			love.graphics.print("Bonus: +"..(pObj.tohitbonus+(math.min(waitturns,3)*0.1))..".0",485,210)
			else
			love.graphics.print("Bonus: +"..(pObj.tohitbonus+(math.min(waitturns,3)*0.1)),485,210)
			end
		
		local thistohit = playerWeapon.tohit * pObj.tohit * ((100 - pObj.pain)/100)
		thistohit = thistohit + pObj.tohitbonus + (math.min(waitturns,3)*(0.1*pBonus.aimfactor))
		if fireturns>1 then
			--if we're rapidfiring for over 1 shot, lose 0.2 (by recoil factor) tohit per shot
			--veteran has an innate 0.7 recoil factor
			thistohit = thistohit * (1 - (fireturns-1)*((0.2*pBonus.rpdrecoilfactor)*(playerClass==4 and 0.7 or 1.0)))
			end
		love.graphics.print("Final ToHit: "..math.floor(thistohit*20)/20,485,225)
		
		local equipment = {playerWeapon,playerArmor}
		local equipnames = {"Weapon: ","Armor:  "}
		for i=1,2 do
			local v = equipment[i]
			if menuselect==i then
				love.graphics.setColor(0.2,1,0.2)
				end
			if v==nil then
				love.graphics.print(equipnames[i].."NONE",135,75+(i*15))
				else
				local xtratxt=""
				if v.type=="weapon" and v.ammotype~="no" then
					xtratxt = " ("..v.ammo.."/"..v.maxammo..")"
					end
				if v.type=="armor" then
					xtratxt = " ("..math.floor(v.durability/v.maxdurability*100).."%)"
					end
				
				
				love.graphics.print(equipnames[i]..v.name..xtratxt,135,75+(i*15))
				end
			love.graphics.setColor(1,0.2,0.2)
			end
		
		local itemsel = equipment[menuselect]
		if itemsel~=nil then
			love.graphics.print(itemsel.name,150,255)
			if itemsel.type=="weapon" then
				love.graphics.print("Damage: "..itemsel.dice.."d"..itemsel.sides.. (itemsel.dmgtype=="spread" and "x9"..(itemsel.shots==nil and "" or "x"..itemsel.shots) or (itemsel.shots==nil and "" or "x"..itemsel.shots)),135,285)
				love.graphics.print("To Hit: "..itemsel.tohit,135,300)
				if itemsel.dmgtype=="spread" then
					love.graphics.print("Choke:  "..itemsel.range-1,135,315)
					love.graphics.printf(itemsel.desc,135,345,500)
					else
					if itemsel.dmgtype=="melee" then
						local chargebar = string.sub("IIIII",1,itemsel.charge)
						love.graphics.print("Charge rating: "..chargebar,135,315)
						love.graphics.printf(itemsel.desc,135,345,500)
						else
						love.graphics.printf(itemsel.desc,135,330,500)
						end
					end
				if itemsel.ammotype~="no" then
					love.graphics.print("Reload time: "..itemsel.reltime/10 .."s",315,285)
					else
					if itemsel.dmgtype=="melee" then
						love.graphics.print("Charge time: "..itemsel.chrgtime/10 .."s",315,285)
						else
						love.graphics.print("Reload time: N/A",315,285)
						end
					end
				love.graphics.print("Fire time:   "..itemsel.atktime/10 .."s",315,300)
				end
			if itemsel.type=="armor" then
				love.graphics.print("Protection: "..itemsel.protection,135,285)
				love.graphics.print("Durability: "..itemsel.maxdurability,135,300)
				love.graphics.print("Move time: +"..(itemsel.movetime*100)-100 .."%",315,285)
				love.graphics.printf(itemsel.desc,135,330,500)
				end
			end
		end
	if gamestate==STATE_RUNSTAT then
		love.graphics.setColor(0,0,0,0.75)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("RUN INFO",120,40)
		
		local diffname = {"easy","normal","hard","hardest"}
		
		--score based on avg time spent per floor
		local avgtime = (runtime/levelnum) / 3600 --1.0 at 6 mins per floor, 2.0 at 12 mins, 0.5 at 3 mins
		avgtime = math.min(avgtime,1.5) --time taken penalty can only go as high as 1.5; this equates to 9 mins
		avgtime = math.max(avgtime,0.5) --time taken penalty can only go as low as 0.5, or 3 mins (double score)
		
		love.graphics.print("Location:     "..levelname,100,80)
		love.graphics.print("Feeling:      "..levelvibes,100,95)
		love.graphics.print("Runtime:      "..timerText(runtime/10).." (avg "..timerText((runtime/levelnum)/10)..")",100,125)
		love.graphics.print("Kills:        "..kills.."/"..enemies.." ("..localenemycount.." left)",100,140)
		love.graphics.print("Difficulty:   "..skillnames[gameskill].." ("..diffname[gameskill]..")",100,170)
		love.graphics.print("Score:        "..math.floor(((pscore/1.1)/avgtime)*(gameskill*0.5 + 0.5)),100,185)
		end
	if gamestate==STATE_LOG then
		love.graphics.setColor(0,0,0,0.95)
		love.graphics.rectangle("fill",0,0,800,480)
		love.graphics.setColor(1,1,1)
		local startindx = math.max(1,(#msglog-23)-menuselect)
		for i=startindx,math.min(#msglog,startindx+24),1 do
			local v = msglog[i]
			local txcol = v[3]
			if txcol==nil then txcol = {1,1,1,0.8} end
			love.graphics.printf({{0.2,1,0.2,1},timerText(v[2]/10),{1.0,0.8,0.2,1},"> ",txcol,v[1]},
				15,(400-(#msglog * 15))+(i+menuselect-1)*15,770)
			end
		love.graphics.setColor(1,0.2,0.2,1.0)
		love.graphics.print("[SHIFT + S] - Save log as .txt file",30,425)
		if menuselect>1 then
			love.graphics.printf("| \nV",770,395,100)
			end
		end
	
	--debug hitscan rays
	if hitscandebug == true then
		love.graphics.setColor(0.8,0,0,0.3)
		for k,v in ipairs(hitscanlines) do
			love.graphics.line(v)
			end
		love.graphics.setColor(1,1,1,1)
		love.graphics.points(hitscanpoints)
		end
	
	if gamestate==STATE_MORTIS then
		love.graphics.clear(0,0,0,1)
		--scroll bar
		love.graphics.setColor(0.3,0.,0.)
		love.graphics.rectangle("fill",730,10,4,460)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.rectangle("fill",727,menuselect*45 - 30,10,25)
		
		love.graphics.printf(mortistxt,80,40 - (menuselect*25),640,"left")
		love.graphics.setColor(0,0,0,1)
		love.graphics.line(0,1,800,1)
		love.graphics.line(0,480,800,480)
		end
	
	--good old CRT camera recording distortion
	love.graphics.setColor(0.2,0.2,0.2,0.2)
	love.graphics.rectangle("fill",1,(frames%4000)*2-600,798,40)
	love.graphics.setColor(0,0,0,1)
	love.graphics.line(0,0,800,0)
	love.graphics.line(0,479,800,479)
	love.graphics.setColor(1,1,1)
	
	local gaussianblurradius = 0.1
	
	--curveshader pass
	love.graphics.setCanvas(screencanvas)
	love.graphics.clear(0,0,0,1)
	--drop shadow like effect
	local brightness = love.math.random()*0.05+0.25
	love.graphics.setColor(brightness,brightness,brightness)
	love.graphics.setShader(curveshader)
	--disabling this as I want to replace it with real chromatic aberration
	--love.graphics.draw(tilecanvas,-(((400*1.01)-(400*1))/1),-(((240*1.01)-(240*1))/1),0,1.01)
	love.graphics.setColor(1,1,1)
	love.graphics.draw(tilecanvas,0,0,0,1)
	--horizontal blur pass
	love.graphics.setShader(horzblurshader)
	love.graphics.setCanvas(horzblurcanvas)
	horzblurshader:send("radius",gaussianblurradius)
	love.graphics.clear()
	love.graphics.draw(screencanvas,0,0)
	--vertical blur pass
	love.graphics.setShader(vertblurshader)
	love.graphics.setCanvas(screencanvas)
	vertblurshader:send("radius",gaussianblurradius)
	love.graphics.clear()
	love.graphics.draw(horzblurcanvas,0,0)
	--and finally we are done
	love.graphics.setShader()
	love.graphics.setCanvas()
	
	--print("screen rendering took "..(love.timer.getTime()-ttt)*1000 .."ms")
	end