function dangerlevel(level,skill)
	local skillfunc = {
		function(l)
			return 1+1.5*(l^1.2)
			end,
		function(l)
			return 1+2*(l^1.3)
			end,
		function(l)
			return 2+2*(l^1.4)
			end,
		function(l)
			return 3+3*(l^1.4)
			end
	}
	return math.floor(skillfunc[skill](level))
	end

function startgame()
	mus.title:stop()
	pStats = {spd = 0,acc = 0,vit = 0,per = 0}
	
	pSkills = {side = 0,rapid = 0,marks = 0,shot = 0,dodge = 0,track = 0,pack = 0,brute = 0}
	pSkillOrder = {}

	pBonus = {
		sidearmdraw = 1.0,sidearmdmgmin = 0,sidearmdmgbuff = 0,
		rpdrecoilfactor = 1.0,rpddmgdebuff = true,
		aimfactor = 1.0,aimdmg = 0,aimshield = false,
		shottohit = 1.0,shotreload = 1.0,shotchokebuff = 0,
		passivedodgerate = 0.0,activedodgerate = 0.0,dodgeshield = false,
		trackdist = 0,stairtracking = false,
		ammocapbuff = 0,invcapbuff = 0,pickupspeed = 1.0,freefifthshot = false,
		meleewaittimefactor = 1.0,meleecritbuff = 0,meleelifesteal = false
	}
	runtime = 0
	enemies = 0
	kills = 0
	levelnum = 1
	pscore = 0
	generatenewlevel("dungeon",true)
	--[[
	makeItemObj("secarm",50,3,4)
	makeItemObj("riotarm",45,4,4)
	makeItemObj("milarm",70,5,4)
	makeItemObj("balarm",120,6,4)
	makeItemObj("nrgarm",150,7,4)
	makeItemObj("m99pis",12,3,6)
	makeItemObj("sawnoff",2,4,6)
	makeItemObj("sm40smg",30,5,6)
	makeItemObj("ca12shotty",6,6,6)
	makeItemObj("ch7pis",15,7,6)
	makeItemObj("sn730rifle",30,8,6)
	makeItemObj("z3rifle",20,9,6)
	
	makeAmmoObj("9mm",30,3,8)
	makeAmmoObj("5mm",20,5,8)
	makeAmmoObj("7mm",15,7,8)
	makeAmmoObj("12ga",4,9,8)
	--]]
	gamestate = STATE_GAME
	msglog = {{"Game set!",0}}
	mkHudmessage("You arrive at the main Nuclear R&D HQ. What a warm welcome.")
	end

function fillsquare(ox,oy,w,h,tile)
	for x=1,w do
		for y=1,h do
			if y<25 and y>0 then
				local spawnableset = Set(spawnabletiles)
				if tile==0 and spawnableset[string.char(ox+x)..string.char(oy+y)]==nil then table.insert(spawnabletiles,string.char(ox+x)..string.char(oy+y)) end
				if tile~=0 and spawnableset[string.char(ox+x)..string.char(oy+y)]~=nil then table.remove(spawnabletiles,spawnableset[string.char(ox+x)..string.char(oy+y)]) end
				tilemap[oy+y][ox+x]=tile
				end
			end
		end
	end
function linesquare(ox,oy,w,h,tilein,tileout)
	fillsquare(ox,oy,w,h,tileout)
	fillsquare(ox+1,oy+1,w-2,h-2,tilein)
	end
function line(ox,oy,vector,length,tile)
	local x=ox
	local y=oy
	for i=1,length do
		if y<25 and y>0 then
			local spawnableset = Set(spawnabletiles)
			if tile==0 and spawnableset[string.char(x)..string.char(y)]==nil then table.insert(spawnabletiles,string.char(x)..string.char(y)) end
			if tile~=0 and spawnableset[string.char(x)..string.char(y)]~=nil then table.remove(spawnabletiles,spawnableset[string.char(x)..string.char(y)]) end
			tilemap[y][x]=tile
			end
		x = x + vector[1]
		y = y + vector[2]
		end
	end
function spray(ox,oy,radx,rady,count,tile,noreplace)
	for i=1,count do
		local x = math.floor(love.math.randomNormal(radx/2,0)+0.5)+ox
		local y = math.floor(love.math.randomNormal(rady/2,0)+0.5)+oy
		if x>2 and x<44 and y>2 and y<24 then
			if tilemap[y][x]~=noreplace then
				local spawnableset = Set(spawnabletiles)
				if tile==0 and spawnableset[string.char(x)..string.char(y)]==nil then table.insert(spawnabletiles,string.char(x)..string.char(y)) end
				if tile~=0 and spawnableset[string.char(x)..string.char(y)]~=nil then table.remove(spawnabletiles,spawnableset[string.char(x)..string.char(y)]) end
				tilemap[y][x]=tile
				end
			end
		end
	end
function pasteprefab(ox,oy,prefab,w,h)
	
	end
function generatenewlevel(roomtype,nofeeling)
	--empty the replay buffer so things don't spill between levels
	replayBuffer = {}
	
	if levelnum>1 then
		lvmus["cluster"..muscluster][clustertrack]:stop()
		end
	local thiscluster = math.floor((levelnum-1)/3)+1
	if love.math.random()<1/(thiscluster^0.41504) then
		muscluster = thiscluster
		else
		muscluster = math.max(1,love.math.random(love.math.random(1,thiscluster-1),thiscluster-1))
		end
	if levelnum%3==1 then
		muscluster = thiscluster
		end
	--print(muscluster)
	clustertrack = love.math.random(1,#lvmus["cluster"..muscluster])
	lvmus["cluster"..muscluster][clustertrack]:play()
	
	roomtype="dungeon"
	spawnabletiles = {}
	tilemap = {}
	for y=1,25 do
		tilemap[y] = {}
		for x=1,45 do
			tilemap[y][x] = 1
			end
		end
	
	playerDodge = false
	waitturns = 0
	controlmode = 0
	
	fObjs={}
	eObjs={}
	iObjs={}
	
	--which type of map generation
	local types = {"dungeon","lobby","smallprefabs"}
	if roomtype==nil then
		roomtype = love.math.random(1,#types)
		roomtype = types[roomtype]
		end
	--what level feeling
	local levelfeeling = nil
	local bonusfeelingrate = 0.0
	if gameskill>1 then bonusfeelingrate = 0.025 end
	if gameskill>3 then bonusfeelingrate = 0.05 end
	if dangerlevel(levelnum,gameskill)>8 then bonusfeelingrate = bonusfeelingrate + 0.025 end
	if dangerlevel(levelnum,gameskill)>16 then bonusfeelingrate = bonusfeelingrate + 0.015 end
	if dangerlevel(levelnum,gameskill)>24 then bonusfeelingrate = bonusfeelingrate + 0.010 end
	if nofeeling~=nil and love.math.random()<0.15+bonusfeelingrate then
		local feeltable = {"acidspill"}
		local mindlevel = {dogs=7,vault=14,robotics=32}
		if dangerlevel(levelnum,gameskill)>mindlevel.dogs then
			table.insert(feeltable,"dogs")
			end
		if dangerlevel(levelnum,gameskill)>mindlevel.vault then
			table.insert(feeltable,"dogs")
			table.insert(feeltable,"vault")
			table.insert(feeltable,"vault")
			table.insert(feeltable,"redalert")
			end
		if dangerlevel(levelnum,gameskill)>mindlevel.robotics then
			table.insert(feeltable,"vault")
			table.insert(feeltable,"redalert")
			table.insert(feeltable,"robotics")
			table.insert(feeltable,"robotics")
			end
		
		levelfeeling = feeltable[love.math.random(1,#feeltable)]
		end
	
	--generate map
	local mapfunc = {
		dungeon = function() --a bunch of adjacent rooms, separated by doorways, with one corridor somewhere through the map
			local corridor = love.math.random(10,31)
			local corridorw = love.math.random(2,5)
			fillsquare(corridor,1,corridorw,23,0)
			local leftcol = math.floor(corridor/9)
			local colx = 1
			local nextrooms = love.math.random(love.math.random(2,3),4)
			for i=1,leftcol do
				local colwidth = math.min(math.floor(corridor/leftcol)+love.math.random(-1,1),(corridor-1)-colx)
				local nexty = 1
				local rooms = nextrooms
				nextrooms = love.math.random(love.math.random(2,3),4)
				if nextrooms==rooms then
					nextrooms = love.math.random(love.math.random(1,2),4)
					end
				for j=1,rooms do
					local roomheight = math.min(math.floor(love.math.random(25/rooms-1,25/rooms+1)),24-nexty)
					fillsquare(colx,nexty,colwidth,roomheight,0)
					if not (rooms==3 and j==2 and nextrooms~=3 and i~=leftcol) then
						line(colx+colwidth,nexty+math.floor(love.math.random(25/rooms-2,25/rooms+2)/2),{1,0},3,0)
						else
						line(colx+colwidth,nexty+math.floor((25/rooms)/3),{1,0},3,0)
						line(colx+colwidth,nexty+math.floor((25/rooms)*(2/3)),{1,0},3,0)
						end
					if love.math.random()<0.7 and j<rooms then
						line(colx+math.floor(colwidth/2)+love.math.random(-1,1),nexty+roomheight,{0,1},3,0)
						end
					nexty = nexty+roomheight+1
					end
				colx = colx+colwidth+1
				end
			local rightcol = math.floor((45-(corridor+corridorw+2))/9)
			local rightsize = 45-(corridor+corridorw+2)
			colx = corridor+corridorw+1
			nextrooms = love.math.random(love.math.random(2,3),4)
			for i=1,rightcol do
				local colwidth = math.min(math.floor(rightsize/rightcol)+love.math.random(-1,1),44-colx)
				local nexty = 1
				local rooms = nextrooms
				nextrooms = love.math.random(love.math.random(2,3),5)
				if nextrooms==rooms then
					nextrooms = love.math.random(love.math.random(1,2),5)
					end
				for j=1,rooms do
					local roomheight = math.min(math.floor(love.math.random(25/rooms-1,25/rooms+1)),24-nexty)
					fillsquare(colx,nexty,colwidth,roomheight,0)
					if not (rooms==3 and j==2 and nextrooms~=3 and i~=rightcol) then
						line(colx-1,nexty+math.floor(love.math.random(25/rooms-2,25/rooms+2)/2),{1,0},3,0)
						else
						if love.math.random()<0.5 then
							line(colx-1,nexty+math.floor((25/rooms)/3),{1,0},3,0)
							else
							line(colx-1,nexty+math.floor((25/rooms)*(2/3)),{1,0},3,0)
							end
						end
					if love.math.random()<0.6 and j<rooms then
						line(colx+math.floor(colwidth/2)+love.math.random(-1,1),nexty+roomheight,{0,1},3,0)
						end
					nexty = nexty+roomheight+1
					end
				colx = colx+colwidth+1
				end
			end,
		lobby = function() --a center lobby with four outer rooms
			fillsquare(2,2,42,22,0)
			end,
		smallprefabs = function() --a grid of small pre-made rooms
			fillsquare(2,2,42,22,0)
			end
	}
	mapfunc[roomtype]()
	
	local acidpuddles = love.math.random(2,4)
	local minpuddlesize = 2
	if levelfeeling=="acidspill" then
		acidpuddles = acidpuddles + 4
		minpuddlesize = 3
		end
	if roomtype~="smallprefabs" then
		for i=1,acidpuddles do
			local sizex = minpuddlesize + love.math.random(0,2)
			local sizey = minpuddlesize + love.math.random(0,1)
			spray(love.math.random(3,42),love.math.random(3,22),sizex,sizey,math.floor((3.14159*sizex*sizey)*love.math.random(0.7,1.3)),2,1)
			end
		end
	
	--spawn the player in one of any of the spawnable tiles
	local spawntile = love.math.random(1,#spawnabletiles)
	pObj.pox = string.byte(string.sub(spawnabletiles[spawntile],1,1))
	pObj.poy = string.byte(string.sub(spawnabletiles[spawntile],2,2))
	table.remove(spawnabletiles,spawntile)
	
	--hook up enemy spawntable
	local enemytable = {}
	local dlevel = dangerlevel(levelnum,gameskill)
	if levelfeeling=="vault" then dlevel = dlevel + 10 end
	for _,v in ipairs(espawntable) do
		if dlevel>v[2]-1 then
			for i=1,v[3] do
				table.insert(enemytable,v[1])
				end
			end
		end
	if levelfeeling=="dogs" then
		local lencancermine = math.floor(#enemytable/1.8)
		for i=1,lencancermine do
			table.insert(enemytable,"secdog")
			if dlevel>love.math.random(20,34) then
				table.insert(enemytable,"mildog")
				else
				table.insert(enemytable,"secdog")
				end
			end
		end
	if levelfeeling=="robotics" then
		local lencancermine = math.floor(#enemytable/3)
		for i=1,lencancermine do
			table.insert(enemytable,"gundrone")
			table.insert(enemytable,"shockdrone")
			end
		end
	
	--spawn the enemies
	local enemycount = math.min(dlevel + 2 + gameskill,math.floor( 20 + (levelnum*(1+gameskill/4)) ) ) + love.math.random(0,2)
	localenemycount = 0
	local hotstartrate = 0.2
	for i=1,enemycount do
		if #spawnabletiles > 40 then
			local spawntile = love.math.random(1,#spawnabletiles)
			local spx = string.byte(string.sub(spawnabletiles[spawntile],1,1))
			local spy = string.byte(string.sub(spawnabletiles[spawntile],2,2))
			local ray = checkLOS(pObj.pox,pObj.poy,spx,spy,nil,true)
			if (ray.type == "wall") or love.math.random()<hotstartrate then
				localenemycount = localenemycount + 1
				makeObj(enemytable[love.math.random(1,#enemytable)],string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2)))
				if ray.hit == nil then
					eObjs[#eObjs].color = {0,1,0,1}
					print("enemy spawned in LOS of player")
					else
					eObjs[#eObjs].color = {1,0,1,1}
					print("enemy spawed outside of LOS of player")
					end
				if love.math.random()<0.6 and levelfeeling=="redalert" then
					eObjs[#eObjs].chasing = true
					end
				end
			table.remove(spawnabletiles,spawntile)
			end
		end
	
	--create items
	local itemcount = love.math.random(-1,4) + math.floor(levelnum/3) + gameskill
	local ln = levelnum
	if gameskill==1 then ln = ln - 3 end
	if levelfeeling=="vault" then ln = ln + 4;itemcount = itemcount + 8 end
	--spawntable
	local itemtable = {}
	for _,v in ipairs(ispawntable) do
		if ln>v[2] then
			for i=1,v[3] do
				table.insert(itemtable,{v[1],v[4]})
				end
			end
		end
	for i=1,itemcount do
		if #spawnabletiles > 30 then
			local spawntile = love.math.random(1,#spawnabletiles)
			local which = love.math.random(1,#itemtable)
			makeItemObj(itemtable[which][1],itemtable[which][2],string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2)))
			table.remove(spawnabletiles,spawntile)
			end
		end
	
	--create ammo
	local ammocount = love.math.random(1,6) + math.floor(levelnum/2) + (gameskill*2)
	local ln = levelnum
	if levelfeeling=="vault" then ln = ln + 6 end
	--spawntable
	local ammotable = {}
	for _,v in ipairs(aspawntable) do
		if ln>v[2] then
			for i=1,v[3] do
				table.insert(ammotable,{v[1],v[4]})
				end
			end
		end
	for i=1,ammocount do
		if #spawnabletiles > 15 then
			local spawntile = love.math.random(1,#spawnabletiles)
			local which = love.math.random(1,#ammotable)
			makeAmmoObj(ammotable[which][1],ammotable[which][2],string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2)))
			table.remove(spawnabletiles,spawntile)
			end
		end
	
	--place the exit somewhere
	local spawntile = love.math.random(1,#spawnabletiles)
	exit.pox = string.byte(string.sub(spawnabletiles[spawntile],1,1))
	exit.poy = string.byte(string.sub(spawnabletiles[spawntile],2,2))
	table.remove(spawnabletiles,spawntile)
	
	local feelingtext = {acidspill = "Your eyes begin to burn.",dogs = "You hear barking and snarling.",vault = "This place seems pretty important.",robotics = "You hear mechanical whirring.",redalert = "Whoops. It seems they expected you."}
	local hm = "You descend to floor "..levelnum..". "
	if levelfeeling~=nil then
		hm = hm..feelingtext[levelfeeling]
		end
	mkHudmessage(hm)
	end
--a list of every coordinate that can have Things spawn in it (including items, the player, enemies, and the exit)
--this system may be incredibly slow and I don't know if it's worth it but ykw fuck it
spawnabletiles = {}

--spawntable including minimum danger levels and weights
--entries are as follows:
--classname, min danger level, weight
--one class can have multiple entries associated with it to gain higher bias as each one's min dlevel is met
espawntable = {
	{"pissecguard",1,3},	-- 1, 1, 1, 1
	{"secdog",6,2},			-- 3, 3, 2, 1
	{"shotsecguard",9,2},	-- 5, 3, 3, 2
	{"secdog",10,1},		-- 5, 4, 3, 2
	{"shotsecguard",11,1},	-- 5, 4, 3, 3
	{"smgtacguard",13,3},	-- 6, 4, 4, 3
	{"secdog",13,2},		-- 6, 4, 4, 3
	{"smgtacguard",16,2},	-- 7, 5, 5, 3
	{"rifletacguard",16,4},	-- 7, 5, 5, 3
	{"secdog",18,3},		-- 8, 6, 5, 4
	{"smgtacguard",20,3},	-- 9, 6, 5, 4
	{"rifletacguard",21,2},	-- 9, 6, 5, 4
	{"riflemilguard",28,5},	--12, 8, 7, 5
	{"mildog",28,3},		--12, 8, 7, 5
	{"mildog",31,4},		--13, 9, 7, 5
	{"shotmilguard",31,4},	--13, 9, 7, 5
	{"riflemilguard",32,2},	--13, 9, 7, 6
	{"shotmilguard",34,6},	--14, 9, 8, 6
	{"mildog",35,4},		--14, 9, 8, 6
	{"riflemilguard",35,4},	--14, 9, 8, 6
	{"shotmilguard",36,6}	--14,10, 8, 6
}
--entries are as follows:
--ammotype, min floor, weight, count
aspawntable = {
	{"9mm",0,6,12},
	{"12ga",2,2,3},
	{"9mm",3,1,30},
	{"5mm",5,1,20},{"12ga",5,2,4},
	{"5mm",7,3,20},{"12ga",7,2,4},
	{"7mm",9,3,20},
	{"7mm",10,3,20}
}
--entries are as follows:
--classname, min floor, weight, count
--on firing blanks you need to be three floors higher to find any given drop
ispawntable = {
	{"m99pis",-3,10,12},{"secarm",-1,4,60},{"sawnoff",1,1,2},
	{"sawnoff",2,4,2},
	{"sm40smg",3,3,30},{"sawnoff",3,1,2},{"secarm",3,3,60},
	{"riotarm",4,5,70},
	{"sm40smg",5,4,30},{"riotarm",5,3,70},
	{"riotarm",7,2,70},
	{"sn730rifle",8,4,30},{"ch7pis",8,4,15},
	{"ca12shotty",10,5,6},{"sn730rifle",10,5,30},{"ch7pis",10,3,15},{"z3rifle",10,3,20},{"balarm",10,2,150},
	{"z3rifle",13,4,20},{"balarm",13,2,150},{"nrgarm",13,2,170}
}