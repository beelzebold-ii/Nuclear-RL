--this is level generation stuff
--luafinding is needed to ensure there's a path from every enemy to the player, and from the exit to the player
local Vector = require( "luafinding/vector" )
local Luafinding = require("luafinding/luafinding")

require("customlevel")
require("presetlevels")
local ENABLE_PRESET_LEVELS = true

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
		ammocapbuff = 0,invcapbuff = 2,pickupspeed = 1.0,freefifthshot = false,
		meleewaittimefactor = 1.0,meleecritbuff = 0,meleelifesteal = false
	}
	
	playerName = defaultnames[love.math.random(1,#defaultnames)]
	
	playerUsingMeds = true
	
	runtime = 0
	enemies = 0
	kills = 0
	levelnum = 1
	area = 1
	layer = 1
	pscore = 0
	
	cheatermode = false
	revealall = false
	
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
function generatenewlevel(roomtype,nofeeling,forcefeeling)
	--empty the replay buffer so things don't spill between levels
	replayBuffer = {}
	
	--label the level
	levelname = "Floor "..levelnum
	levelvibes = "None"
	
	--set the area number properly
	area = math.floor((levelnum-1)/4)+1
	
	--color walls and floors
	tilecolor[2] = areacolors[layer][math.min(area,#areacolors[layer])][1]
	tilecolor[1] = areacolors[layer][math.min(area,#areacolors[layer])][2]
	
	if muscluster then
		lvmus["cluster"..muscluster][clustertrack]:stop()
		else
		love.audio.stop()
		end
	
	if (presetlevels[levelnum]==nil or presetlevels[levelnum][layer]==nil) or ENABLE_PRESET_LEVELS~=true then
		--generate a level
		local thiscluster = math.floor((levelnum-1)/3)+1
		thiscluster = math.min(thiscluster,5)
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
		
		spawnabletiles = {}
		tilemap = {}
		for y=1,25 do
			tilemap[y] = {}
			for x=1,45 do
				tilemap[y][x] = 1
				end
			end
		seentiles = {}
		for y=1,25 do
			seentiles[y] = {}
			for x=1,45 do
				seentiles[y][x] = 0
				end
			end
		
		playerDodge = false
		waitturns = 0
		controlmode = 0
		
		fObjs={}
		eObjs={}
		iObjs={}
		
		--which type of map generation
		local types = {"dungeon","maze","lobby"}
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
		if forcefeeling~=nil then
			levelfeeling = forcefeeling
			end
		--displayed name for levelfeelings
		feelingvibes = {
			acidspill = "Acid Spill",
			dogs = "Kennels",
			vault = "Vault",
			redalert = "Red Alert",
			robotics = "Robotics",
		}
		if levelfeeling~=nil then
			levelvibes = feelingvibes[levelfeeling]
			end
		
		--generate map
		local mapfunc = {
			dungeon = function() --a bunch of adjacent rooms, separated by doorways, with one corridor somewhere through the map
				--god what a mess... oh well
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
				fillsquare(1,1,43,23,0)
				linesquare(12,1,21,23,0,1)
				line(2,13,{1,0},11,1)
				line(34,13,{1,0},11,1)
				local roompos = {
					{x=1,y=1},
					{x=1,y=13},
					{x=33,y=1},
					{x=33,y=13}
				}
				line(11,7,{1,0},3,0)
				line(11,19,{1,0},3,0)
				line(31,7,{1,0},3,0)
				line(31,19,{1,0},3,0)
				for i=1,4 do
					local rooms = {
						"office",
						"ware",
						"acid",
						"server",
						"maze"
					}
					local thisroom = rooms[love.math.random(1,#rooms)]
					local roomfunc = {
						office = function(x,y)--workspaces of a sort
							linesquare(x+1,y+1,9,9,0,1)
							fillsquare(x+1,y+3,9,1,0)
							fillsquare(x+1,y+7,9,1,0)
							local linesf = {
								function()
									fillsquare(x+1,y+5,9,1,1)
									end,
								function()
									fillsquare(x+5,y+1,1,9,1)
									end,
								function()
									fillsquare(x+5,y+1,1,9,1)
									fillsquare(x+1,y+5,9,1,1)
									end,
							}
							linesf[love.math.random(1,3)]()
							end,
						ware = function(x,y)--a bunch o squares
							local numpillars = love.math.random(4,12)
							for i=1,numpillars do
								local pillarsize = love.math.random(1,3)
								fillsquare(x+love.math.random(1,10-pillarsize),y+love.math.random(1,10-pillarsize),pillarsize,pillarsize,1)
								end
							end,
						acid = function(x,y)--a central vat (or vats) of acid
							fillsquare(x+1,y+1,9,9,2)
							if love.math.random()<0.55 then
								line(x+1,y+6,{1,0},11,0)
								end
							if love.math.random()<0.55 then
								line(x+6,y+1,{0,1},11,0)
								end
							end,
						server = function(x,y)--just a grid of pillars
							for i=0,24 do
								fillsquare(x + ((i%5)*2)+1,y + (math.floor(i/5)*2)+1,1,1,1)
								end
							end,
						maze = function(x,y)--weird claustrophobic cooridors, not another dfs maze
							linesquare(x+1,y+1,9,9,0,1)
							linesquare(x+1,y+3,9,5,0,1)
							fillsquare(x+3,y+1,1,9,1)
							fillsquare(x+5,y+1,1,9,1)
							fillsquare(x+7,y+1,1,9,1)
							fillsquare(x+1,y+5,9,1,1)
							for i=1,80,2 do
								if love.math.random()<0.65 then
									fillsquare((x+(i%9))+1,y+math.floor(i/9)+1,1,1,0)
									if love.math.random()<0.235 then
										fillsquare((x+(i%9))+1,y+math.floor(i/9)+1,1,1,2)
										end
									end
								end
							end,
					}
					roomfunc[thisroom](roompos[i].x,roompos[i].y)
					end
				--then populate the center lobby
				local rooms = {
					"office",
					"ware",
					"acid",
					"maze"
				}
				local roomfunc = {
					office = function(x,y)--grid of cubicles
						makeOffice = function(x,y)
							linesquare(x+1,y+1,9,9,0,1)
							fillsquare(x+3,y+1,1,9,0)
							fillsquare(x+7,y+1,1,9,0)
							local linesf = {
								function()
									fillsquare(x+1,y+5,9,1,1)
									end,
								function()
									fillsquare(x+5,y+1,1,9,1)
									end,
								function()
									fillsquare(x+5,y+1,1,9,1)
									fillsquare(x+1,y+5,9,1,1)
									end,
							}
							linesf[love.math.random(1,3)]()
							end
						makeOffice(x+1,y+1)
						makeOffice(x+9,y+1)
						makeOffice(x+1,y+11)
						makeOffice(x+9,y+11)
						end,
					ware = function(x,y)--a bunch o squares
						local numpillars = love.math.random(15,33)
						for i=1,numpillars do
							local pillarsize = love.math.random(1,3)
							fillsquare(x+love.math.random(2,19-pillarsize),y+love.math.random(2,20-pillarsize),pillarsize,pillarsize,1)
							end
						end,
					acid = function(x,y)--a central vat (or vats) of acid
						fillsquare(x+2,y+2,17,19,2)
						if love.math.random()<0.55 then
							line(x+2,y+12,{1,0},19,0)
							end
						if love.math.random()<0.55 then
							line(x+11,y+2,{0,1},20,0)
							end
						if love.math.random()<0.75 then
							fillsquare(x+8,y+9,5,5,0)
							end
						end,
					maze = function(x,y)--dfs maze :pensive:
						fillsquare(x+2,y+2,17,19,1)
						line(x+2,y+12,{1,0},2,0)
						line(x+10,y+2,{0,1},2,0)
						line(x+18,y+12,{1,0},2,0)
						line(x+12,y+20,{0,1},2,0)
						if love.math.random()<0.5 then
							fillsquare(x+2,y+1,1,1,1)
							fillsquare(x+18,y+21,1,1,1)
							else
							fillsquare(x+2,y+21,1,1,1)
							fillsquare(x+18,y+1,1,1,1)
							end
						--IT'S TIME FOR MORE MAZE CODE
						--well it's just copy pasted and modified but.
						--maze grid this time is uhhhh ok this is gonna take a bit
						--17x19 on the outside
						--that means 15x17 on the inside
						--I think 8x9?
						local mazegrid = {}
						for x=1,8 do
							mazegrid[x] = {0,0,0,0,0,0,0,0,0}
							end
						--select a starting tile
						local startx,starty = love.math.random(1,8),love.math.random(1,9)
						--simply direction vectors.
						local directionvectors = {
							{0,-1},--up
							{1,0},--right
							{0,1},--down
							{-1,0}--left
						}
						--mark the starting cell as visited and clear it out
						mazegrid[startx][starty] = 1
						--we use fillsquare here as it correctly populates the spawnabletiles set
						-- (and everywhere else)^
						fillsquare((startx*2)+x+1,(starty*2)+y+1,1,1,0)
						--keep track of the number of (unique) cells we've visited so we know when they've all been visited
						local visitedcells = 1
						--keep the history of visited cells, and pull from it like a stack when we need to backtrack
						--this is initialized to empty. we will add the start pos to it whenever we move from the starting cell.
						local cellhistory = {}
						--obviously we need to know what cell we're currently at
						local curx,cury = startx,starty
						--for as long as there are cells left to visit, run this loop
						while visitedcells<8*9 do
							--unvisited directions, just so we don't have to get stuck in a loop of generating random numbers
							local unvisdirs = {}
							--populate that above list
							for i=1,4 do
								local dirv = directionvectors[i]
								--if the tile in this direction is OoB then it can't be visited
								if not (curx+dirv[1]>8 or curx+dirv[1]<1 or cury+dirv[2]>9 or cury+dirv[2]<1) then
									if mazegrid[curx+dirv[1]][cury+dirv[2]]==0 then
										table.insert(unvisdirs,i)
										end
									end
								end
							--if there are no unvisited directions, backtrack.
							-- (and do nothing else, the loop will continue from the previous cell as normal)
							--otherwise continue with the loop
							if #unvisdirs==0 then--BACKTRACK!!
								if #cellhistory==0 then--if we're at the start cell and must backtrack, we need to bail.
									break
									end
								curx = cellhistory[#cellhistory][1]
								cury = cellhistory[#cellhistory][2]
								table.remove(cellhistory)--should remove the last value in the table, like popping from a stack
								else--SELECT A DIRECTION
								--select a random unvisited direction
								local dir = unvisdirs[love.math.random(1,#unvisdirs)]
								local dirv = directionvectors[dir]
								--add current cell to the history as we're about to move off of it
								table.insert(cellhistory,{curx,cury})
								--clear the wall between this cell and the next one
								fillsquare((curx*2)+dirv[1]+x+1,(cury*2)+dirv[2]+y+1,1,1,0)
								--go to the next cell, clear it, and set it as visited (incrementing visitedcells as well)
								curx = curx + dirv[1]			--next cell
								cury = cury + dirv[2]
								fillsquare((curx*2)+x+1,(cury*2)+y+1,1,1,0)	--clear it
								mazegrid[curx][cury] = 1		--mark visited
								visitedcells = visitedcells+1	--increment
								end
							end
						--once the DFS maze is finished generating, go through and knock down a few walls to make it a bit
						--less linear and claustrophobic
						local wallstodemolish = love.math.random(6,10)
						for i=1,wallstodemolish do
							local demox,demoy = love.math.random(1,7),love.math.random(1,8)
							fillsquare(demox*2+x+1,demoy*2+y+2,1,1,0)
							demox,demoy = love.math.random(1,7),love.math.random(1,8)
							fillsquare(demox*2+x+2,demoy*2+y+1,1,1,0)
							end
						end,
					}
				local thisroom = rooms[love.math.random(1,#rooms)]
				roomfunc[thisroom](12,1)
				end,
			maze = function() --a grid of MAZE
				fillsquare(2,2,42,22,1)
				--fillsquare(20,11,5,3,0)
				--initialize a grid of all 0 (unvisited maze cells)
				--mazegrid is 11x6
				local mazegrid = {}
				for x=1,11 do
					mazegrid[x] = {0,0,0,0,0,0}
					end
				--select a starting tile
				local startx,starty = love.math.random(1,11),love.math.random(1,6)
				--simply direction vectors.
				local directionvectors = {
					{0,-1},--up
					{1,0},--right
					{0,1},--down
					{-1,0}--left
				}
				--mark the starting cell as visited and clear it out
				mazegrid[startx][starty] = 1
				--we use fillsquare here as it correctly populates the spawnabletiles set
				-- (and everywhere else)^
				--and because cells are now 2x2
				fillsquare(startx*4-3,starty*4-3,2,2,0)
				--keep track of the number of (unique) cells we've visited so we know when they've all been visited
				local visitedcells = 1
				--keep the history of visited cells, and pull from it like a stack when we need to backtrack
				--this is initialized to empty. we will add the start pos to it whenever we move from the starting cell.
				local cellhistory = {}
				--obviously we need to know what cell we're currently at
				local curx,cury = startx,starty
				--for as long as there are cells left to visit, run this loop
				while visitedcells<11*6 do
					--unvisited directions, just so we don't have to get stuck in a loop of generating random numbers
					local unvisdirs = {}
					--populate that above list
					for i=1,4 do
						local dirv = directionvectors[i]
						--if the tile in this direction is OoB then it can't be visited
						if not (curx+dirv[1]>11 or curx+dirv[1]<1 or cury+dirv[2]>6 or cury+dirv[2]<1) then
							if mazegrid[curx+dirv[1]][cury+dirv[2]]==0 then
								table.insert(unvisdirs,i)
								end
							end
						end
					--if there are no unvisited directions, backtrack.
					-- (and do nothing else, the loop will continue from the previous cell as normal)
					--otherwise continue with the loop
					if #unvisdirs==0 then--BACKTRACK!!
						if #cellhistory==0 then--if we're at the start cell and must backtrack, we need to bail.
							break
							end
						curx = cellhistory[#cellhistory][1]
						cury = cellhistory[#cellhistory][2]
						table.remove(cellhistory)--should remove the last value in the table, like popping from a stack
						else--SELECT A DIRECTION
						--select a random unvisited direction
						local dir = unvisdirs[love.math.random(1,#unvisdirs)]
						local dirv = directionvectors[dir]
						--add current cell to the history as we're about to move off of it
						table.insert(cellhistory,{curx,cury})
						--clear the wall between this cell and the next one
						fillsquare(curx*4+dirv[1]*2-3,cury*4+dirv[2]*2-3,2,2,0)
						--go to the next cell, clear it, and set it as visited (incrementing visitedcells as well)
						curx = curx + dirv[1]			--next cell
						cury = cury + dirv[2]
						fillsquare(curx*4-3,cury*4-3,2,2,0)	--clear it
						mazegrid[curx][cury] = 1		--mark visited
						visitedcells = visitedcells+1	--increment
						end
					end
				--once the DFS maze is finished generating, go through and knock down a few walls to make it a bit
				--less linear and claustrophobic
				local wallstodemolish = love.math.random(4,8)
				for i=1,wallstodemolish do
					local demox,demoy = love.math.random(1,10),love.math.random(1,5)
					fillsquare(demox*4-3,demoy*4-1,2,2,0)
					demox,demoy = love.math.random(1,10),love.math.random(1,5)
					fillsquare(demox*4-1,demoy*4-3,2,2,0)
					end
				end
		}
		mapfunc[roomtype]()
		
		local acidpuddles = love.math.random(2,4)
		local minpuddlesize = 2
		if roomtype=="lobby" then
			acidpuddles = acidpuddles - 3
			minpuddlesize = 0
			end
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
		if levelfeeling=="vault" then dlevel = dlevel + 10 + (3 * gameskill) end
		for _,v in ipairs(espawntable) do
			if dlevel>v[2]-1 then
				for i=1,v[3] do
					table.insert(enemytable,v[1])
					end
				end
			end
		if levelfeeling=="dogs" then
			local lencancermine = math.floor(#enemytable/1.5)
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
			local lencancermine = math.floor(#enemytable/2.2)
			for i=1,lencancermine do
				table.insert(enemytable,"gundrone")
				table.insert(enemytable,"shockdrone")
				end
			end
		
		--spawn the enemies
		local enemycount = math.min(dlevel + 2 + gameskill,math.floor( 20 + (levelnum*(1+gameskill/4)) ) ) + love.math.random(0,2)
		if levelfeeling=="dogs" then
			enemycount = math.floor(enemycount * 1.4)
			end
		localenemycount = 0
		local hotstartrate = 0.2
		for i=1,enemycount do
			if #spawnabletiles > 40 then
				local spawntile = love.math.random(1,#spawnabletiles)
				local spx = string.byte(string.sub(spawnabletiles[spawntile],1,1))
				local spy = string.byte(string.sub(spawnabletiles[spawntile],2,2))
				local ray = checkLOS(pObj.pox,pObj.poy,spx,spy,nil,true)
				
				ignoreobj = -2
				local pathmap = makepathmap(true)
				local path = Luafinding( Vector(string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2))), Vector(pObj.pox,pObj.poy), pathmap):GetPath()
				
				if path~=nil and #path>=2 then
					if (ray.type == "wall") or love.math.random()<hotstartrate then
						localenemycount = localenemycount + 1
						makeObj(enemytable[love.math.random(1,#enemytable)],string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2)))
						--if ray.hit == nil then
						--	eObjs[#eObjs].color = {0,1,0,1}
						--	print("enemy spawned in LOS of player")
						--	else
						--	eObjs[#eObjs].color = {1,0,1,1}
						--	print("enemy spawed outside of LOS of player")
						--	end
						if love.math.random()<0.6 and levelfeeling=="redalert" then
							eObjs[#eObjs].chasing = true
							end
						--dogs have a 40% chance to spawn chasing the player in dog levels
						if levelfeeling=="dogs" and love.math.random()<0.4 and
							(eObjs[#eObjs].name=="Security Dog" or eObjs[#eObjs].name=="Militia Dog") then
							eObjs[#eObjs].chasing = true
							end
						end
					else
					enemycount = enemycount + 1
					end
				table.remove(spawnabletiles,spawntile)
				end
			end
		
		--create items
		local itemcount = love.math.random(3,6) + math.floor(levelnum/2) + gameskill
		local ln = levelnum
		if gameskill==1 then ln = ln - 2 end
		if gameskill==4 then ln = ln + 1 end
		if levelfeeling=="vault" then ln = ln + 4;itemcount = itemcount + 8 + math.floor(levelnum/2) end
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
		local ammocount = love.math.random(3,7) + math.floor(levelnum/1.75) + (gameskill*2)
		local ln = levelnum
		if levelfeeling=="vault" then ln = ln + 6;ammocount = math.floor(ammocount * 1.5) end
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
		local exitplaced = false
		while exitplaced == false do
			if #spawnabletiles > 1 then
				local spawntile = love.math.random(1,#spawnabletiles)
				
				ignoreobj = -2
				local pathmap = makepathmap(true)
				local path = Luafinding( Vector(string.byte(string.sub(spawnabletiles[spawntile],1,1)),string.byte(string.sub(spawnabletiles[spawntile],2,2))), Vector(pObj.pox,pObj.poy), pathmap):GetPath()
				
				if path~=nil and #path>=2 then
					exit.pox = string.byte(string.sub(spawnabletiles[spawntile],1,1))
					exit.poy = string.byte(string.sub(spawnabletiles[spawntile],2,2))
					exitplaced = true
					end
				table.remove(spawnabletiles,spawntile)
				else
				exit.pox = pObj.pox
				exit.poy = pObj.poy
				exitplaced = true
				end
			end
		
		local feelingtext = {acidspill = "Your eyes begin to burn.",dogs = "You hear barking and snarling.",vault = "This place seems pretty important.",robotics = "You hear mechanical whirring.",redalert = "Whoops. It seems they expected you."}
		local hm = "You descend to floor "..levelnum..". "
		if levelfeeling~=nil then
			hm = hm..feelingtext[levelfeeling]
			end
		mkHudmessage(hm)
		else
		--choose the correct preset level
		local plevel = presetlevels[levelnum][layer]
		if plevel == nil or plevel.filename == nil then
			error("attempted to load level that does not exist",2)
			return
			end
		plevel.music:setVolume(config.mus/15)
		plevel.music:setLooping(true)
		plevel.music:play()
		--mkHudmessage("You descend to "..plevel.name)
		mkHudmessage(plevel.entrytext)
		
		levelname = plevel.name
		
		feelingvibes = {
			acidspill = "Acid Spill",
			dogs = "Kennels",
			vault = "Vault",
			redalert = "Red Alert",
			robotics = "Robotics",
		}
		if plevel.feeling~=nil then
			levelvibes = feelingvibes[plevel.feeling]
			else
			levelvibes = "None"
			end
		
		levelstr = love.filesystem.read(plevel.filename)
		LoadLevel(levelstr)
		end
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
	{"shotmilguard",36,6},	--14,10, 8, 6
	{"riflemilguard",40,4}, --16,10, 9, 7
	{"shockdrone",42,5},	--16,11, 9, 7
	{"gundrone",45,4},		--17,11, 9, 7
	{"shockdrone",48,3},	--18,12,10, 7
	{"shotmilguard",50,6},	--19,12,10, 8
	{"gundrone",52,6},		--19,13,10, 8
	{"mildog",56,6},		--21,13,11, 8
	{"riflemilguard",60,8},	--22,14,12, 9
	{"shockdrone",64,5},	--23,15,12, 9
	{"gundrone",65,6},		--23,15,12, 9
}
--entries are as follows:
--ammotype, min floor, weight, count
aspawntable = {
	{"9mm",0,7,12},
	{".35",0,1,6},
	{"12ga",2,3,3},{".35",2,2,10},
	{"9mm",3,1,30},{"12ga",3,1,4},{"5mm",3,1,10},
	{"5mm",4,2,10},{"7mm",4,1,10},
	{"5mm",5,1,20},{"12ga",5,2,5},{".35",5,1,10},
	{"7mm",6,3,20},
	{"5mm",7,3,20},{"12ga",7,2,6},
	{"12ga",8,4,8},
	{"7mm",9,3,20},{".35",9,1,12},
	{"7mm",10,3,20},{".35",10,1,12},
}
--entries are as follows:
--classname, min floor, weight, count
--on firing blanks you need to be two floors higher to find any given drop
--on goin' nuclear you need to be one floor lower to find them.
ispawntable = {
	{"m99pis",-3,8,12},{"painkiller",-3,2,1},{"bandage",-3,2,1},
	{"painkiller",-1,2,1},{"secarm",-1,4,60},
	{"autopis",0,1,20},
	{"sawnoff",1,1,2},{"baton",1,1,0},{"bandage",2,2,1},
	{"sawnoff",2,5,2},{"machete",2,2,0},{"witchmag",2,4,6},{"medikit",2,1,1},{"bandage",2,2,1},
	{"sm40smg",3,3,30},{"sawnoff",3,1,2},{"secarm",3,3,60},{"riotarm",3,1,70},{"adrenaline",3,2,1},
	{"riotarm",4,5,70},{"machete",4,1,0},{"mk23pis",4,4,9},{"knuckles",4,1,0},{"bandage",4,2,1},{"medikit",4,3,1},
	{"sm40smg",5,4,30},{"riotarm",5,3,70},{"knuckles",5,2,0},{"huntrifle",5,3,10},{"ch7pis",5,4,15},
	{"mk23pis",6,2,9},{"huntrifle",6,4,10},{"traumakit",6,1,1},{"medikit",6,2,1},{"adrenaline",6,2,1},{"ca12shotty",6,3,6},{"milarm",6,2,100},
	{"riotarm",7,4,70},{"milarm",7,4,100},{"traumakit",7,4,1},{"combatstim",7,3,1},{"ca12shotty",7,5,6},
	{"sn730rifle",8,4,30},{"ch7pis",8,4,15},{"combatstim",8,2,1},{"traumakit",8,3,1},{"medikit",8,2,1},
	{"bossrifle",9,4,8},{"huntrifle",9,1,10},{"z3rifle",9,1,20},{"ch9pis",9,3,15},{"milarm",9,6,100},
	{"ca12shotty",10,5,6},{"sn730rifle",10,5,30},{"ch7pis",10,3,15},{"z3rifle",10,3,20},{"balarm",10,3,150},
	{"traumakit",11,2,1},{"medikit",11,1,1},{"adrenaline",11,2,1},{"combatstim",11,2,1},{"ch9pis",11,3,15},
	{"bossrifle",12,4,8},{"z3rifle",12,3,20},{"ca12shotty",12,5,6},
	{"z3rifle",13,4,20},{"balarm",13,5,150},{"nrgarm",13,4,170},
	{"nrgarm",14,4,170},{"magsmg",14,6,22},{"z3rifle",14,4,20},{"combatstim",14,4,1},{"traumakit",14,6,1},
	{"ch9pis",15,5,15},{"g26rifle",15,4,21},{"machinegun",15,3,50},
	{"autoshotty",16,5,12},{"supershotgun",16,4,2},{"nrgarm",16,5,170},{"magsmg",16,4,22},{"z3rifle",16,4,20},
	{"traumakit",17,7,1},{"balarm",17,6,150},{"ch9pis",17,5,15},{"supershotgun",17,5,2},
}
--separated spawntables in preparation for a more organized system with the ability to selectively spawn different types of items

--just weapons
ispawntablew = {
	{"m99pis",-3,8,12},
	{"autopis",0,1,20},
	{"sawnoff",1,1,2},{"baton",1,1,0},
	{"sawnoff",2,5,2},{"machete",2,2,0},{"witchmag",2,4,6},
	{"sm40smg",3,3,30},{"sawnoff",3,1,2},
	{"machete",4,1,0},{"mk23pis",4,4,9},{"knuckles",4,1,0},
	{"sm40smg",5,4,30},{"knuckles",5,2,0},{"huntrifle",5,3,10},{"ch7pis",5,4,15},
	{"mk23pis",6,2,9},{"huntrifle",6,4,10},{"ca12shotty",6,3,6},
	{"ca12shotty",7,5,6},
	{"sn730rifle",8,4,30},{"ch7pis",8,4,15},
	{"bossrifle",9,4,8},{"huntrifle",9,1,10},{"z3rifle",9,1,20},{"ch9pis",9,3,15},
	{"ca12shotty",10,5,6},{"sn730rifle",10,5,30},{"ch7pis",10,3,15},{"z3rifle",10,3,20},
	{"ch9pis",11,3,15},
	{"z3rifle",12,3,20},{"ca12shotty",12,5,6},
	{"z3rifle",13,4,20},
	{"magsmg",14,6,22},{"z3rifle",14,4,20},
	{"ch9pis",15,5,15},{"g26rifle",15,4,21},{"machinegun",15,3,50},
	{"autoshotty",16,5,12},{"supershotgun",16,4,2},{"magsmg",16,4,22},{"z3rifle",16,4,20},
	{"ch9pis",17,5,15},{"supershotgun",17,5,2},
}
--just armor
ispawntablea = {
	{"secarm",-1,4,60},
	{"secarm",3,3,60},{"riotarm",3,1,70},
	{"riotarm",4,5,70},
	{"riotarm",5,3,70},
	{"milarm",6,2,100},
	{"riotarm",7,4,70},{"milarm",7,4,100},
	{"milarm",9,6,100},
	{"balarm",10,3,150},
	{"balarm",13,5,150},{"nrgarm",13,4,170},
	{"nrgarm",14,4,170},
	{"nrgarm",16,5,170},
	{"balarm",17,6,150},
}
--just medical equipment
ispawntablem = {
	
}