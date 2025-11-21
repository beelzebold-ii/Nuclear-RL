local json = require("json")

function LoadLevel(levelstring)
	local ok,result = pcall(json.decode,levelstring)
	local leveldat = nil
	if ok == false then
		print("error decoding level JSON!")
		return
		else
		leveldat = result
		end
	
	--initialize empty level
	--empty the replay buffer so things don't spill between levels
	replayBuffer = {}
	
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
	
	localenemycount = 0
	
	fObjs={}
	eObjs={}
	iObjs={}
	
	tilemap = leveldat.tilemap
	pObj.pox = leveldat.pObj.pox
	pObj.poy = leveldat.pObj.poy
	exit = leveldat.exit
	secretexit = leveldat.secret
	for i,o in ipairs(leveldat.eObjs) do
		if (o.above==true and gameskill>=o.skill) or (o.above==false and gameskill<=o.skill) then
			makeObj(o.cname,o.pox,o.poy)
			localenemycount = localenemycount + 1
			end
		end
	for i,o in ipairs(leveldat.iObjs) do
		if (o.above==true and gameskill>=o.skill) or (o.above==false and gameskill<=o.skill) then
			if o.item.type~="ammo" then
				makeItemObj(o.cname,nil,o.pox,o.poy)
				else
				makeAmmoObj(o.cname,o.item.amount,o.pox,o.poy)
				end
			end
		end
	end