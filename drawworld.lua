--
--graphicalrender = true
function drawworld(camx,camy)
	camx = math.min(math.max(pObj.pox-7,1),45-14)
	camy = math.min(math.max(pObj.poy-4,1),25-7)
	if graphicalrender then
		drawworldGRAPHIC(camx,camy)
		else
		drawworldASCII(1,1)
		end
	end
function drawObjs(camx,camy)
	camx = math.min(math.max(pObj.pox-7,1),45-14)
	camy = math.min(math.max(pObj.poy-4,1),25-7)
	if graphicalrender then
		drawObjsGRAPHIC(camx,camy)
		else
		drawObjsASCII(1,1)
		end
	end


--ASCII drawing functions!!
function drawworldASCII(camx,camy)
	for ty=camy,camy+24 do
		for tx=camx,camx+44 do
			local brightness = 1
			local dist = distance(tx,ty,pObj.pox,pObj.poy)
			if dist > pObj.viewdist-1 then brightness = 0.7 end
			if dist > pObj.viewdist then brightness = 0.4 end
			if dist > pObj.viewdist+1 then brightness = 0 end
			
			if dist <= pObj.viewdist+1 then
				local rayhit = checkLOS(pObj.pox,pObj.poy,tx,ty,-1,true)
				if rayhit.type~="none" then
					if rayhit.type=="error" or math.abs(rayhit.hit.pox-tx)>=1. or math.abs(rayhit.hit.poy-ty)>=1. then brightness = 0 end
					end
				end
			
			if revealall == true or seentiles[ty][tx]==1 then brightness = math.max(0.3,brightness) end
			
			if brightness > 0 then
				--if tile is in LOS and hasn't been seen yet, mark it as seen
				if seentiles[ty][tx]==0 then
					seentiles[ty][tx]=1
					end
				--if this tile is floor or acid and within 6 tiles, mark adjacent walls as seen
				if tilemap[ty][tx]==0 or tilemap[ty][tx]==2 then
					if dist < 7 then
						local vectors = { --direction vectors
							{0,1},
							{0,-1},
							{1,0},
							{-1,0}
						}
						for i=1,4 do --loop through directions and mark walls as seen
							if tilemap[ty+vectors[i][2]][tx+vectors[i][1]]==1 then
								seentiles[ty+vectors[i][2]][tx+vectors[i][1]] = 1
								end
							end
						end
					end
				end
			--draw the tile at tx,ty
			tilecolor[tilemap[ty][tx]+1][4]=brightness
			love.graphics.setColor(tilecolor[tilemap[ty][tx]+1])
			if exit.pox == tx and exit.poy == ty and seentiles[ty][tx]==1 then
				love.graphics.setColor(0.8,0.5,0.4)
				love.graphics.print(">",(tx*15)+50-7,(ty*15)+15-8)
				else
				love.graphics.print(tilechar[tilemap[ty][tx]+1],(tx*15)+50-7,(ty*15)+15-8)
				end
			end
		end
	end
function drawObjsASCII(camx,camy)
	foreach(fObjs,objDrawASCII)
	foreach(iObjs,objDrawASCII)
	objDrawASCII({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.5,1}})
	if localenemycount==0 then
		objDrawASCII({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.7,1}},true)
		end
	foreach(eObjs,objDrawASCII)
	objDrawASCII(pObj)
	if controlmode==M_FIRING then
		objDrawASCII({pox=cursorx,poy=cursory,char="X",color={0.5,0,0,1}},true)
		end
	end
--actual function that draws individual objs
function objDrawASCII(o,alwaysdraw)
	local isfobj = false
	if o.health==nil then isfobj = true end
	if alwaysdraw==nil then
		if o.health ~= nil and o.health<=0 then return end
		local stairtrackdist = 0
		if pObj.pox==exit.pox and pObj.poy==exit.poy and waitturns>0 and pBonus.stairtracking==true then stairtrackdist=99 end
		if revealall == true then stairtrackdist=99 end
		if distance(o.pox,o.poy,pObj.pox,pObj.poy)>pObj.viewdist+pBonus.trackdist+stairtrackdist then return end
		if o ~= pObj and distance(o.pox,o.poy,pObj.pox,pObj.poy)>pBonus.trackdist+stairtrackdist+1 then
			local rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,o.id)
			if rayhit.type ~= "obj" or rayhit.hit ~= o then
				rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,0,true,nil)
				if rayhit.type ~= "none" then
					return
					end
				end
			end
		end
	
	local sx,sy=(o.pox*15)+50-7,(o.poy*15)+15-8
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",sx,sy,15,15)
	love.graphics.setColor(o.color)
	if o.pox>45 or o.poy>25 or o.pox<1 or o.poy<1 then return end
	if isfobj==true and tilemap[o.poy][o.pox]==2 then--apparently this fucking explodes somehow but I'm too lazy to fix it rn so TODO: that lmao :3
		love.graphics.setColor(tilecolor[3][1],tilecolor[3][2],tilecolor[3][3],1)
		end
	
	if o.justfired==true and frames%10<5 then love.graphics.setColor(1,0.6,0,1) end
	if isfobj==true and tilemap[o.poy][o.pox]==1 then
		love.graphics.print("#",sx,sy)
		else
		love.graphics.print(o.char,sx,sy)
		end
	end


--GRAPHICAL drawing functions!!
function drawworldGRAPHIC(camx,camy)
	for ty=camy,camy+7 do
		for tx=camx,camx+14 do
			local brightness = 1
			local dist = distance(tx,ty,pObj.pox,pObj.poy)
			if dist > pObj.viewdist-1 then brightness = 0.7 end
			if dist > pObj.viewdist then brightness = 0.4 end
			if dist > pObj.viewdist+1 then brightness = 0 end
			
			if dist <= pObj.viewdist+1 then
				local rayhit = checkLOS(pObj.pox,pObj.poy,tx,ty,-1,true)
				if rayhit.type~="none" then
					if rayhit.type=="error" or math.abs(rayhit.hit.pox-tx)>=1. or math.abs(rayhit.hit.poy-ty)>=1. then brightness = 0 end
					end
				end
			
			if revealall == true or seentiles[ty][tx]==1 then brightness = math.max(0.3,brightness) end
			
			if brightness > 0 then
				--if tile is in LOS and hasn't been seen yet, mark it as seen
				if seentiles[ty][tx]==0 then
					seentiles[ty][tx]=1
					end
				--if this tile is floor or acid and within 6 tiles, mark adjacent walls as seen
				if tilemap[ty][tx]==0 or tilemap[ty][tx]==2 then
					if dist < 7 then
						local vectors = { --direction vectors
							{0,1},
							{0,-1},
							{1,0},
							{-1,0}
						}
						for i=1,4 do --loop through directions and mark walls as seen
							if tilemap[ty+vectors[i][2]][tx+vectors[i][1]]==1 then
								seentiles[ty+vectors[i][2]][tx+vectors[i][1]] = 1
								end
							end
						end
					end
				end
			--draw the tile at tx,ty
			--draw floors darker than they rly are
			if tilemap[ty][tx] == 0 then brightness = brightness * 0.55 end
			tilecolor[tilemap[ty][tx]+1][4]=brightness
			love.graphics.setColor(tilecolor[tilemap[ty][tx]+1])
			
			if tilemap[ty][tx] == 1 then
				local tquad = getWallTile(tx,ty)
				love.graphics.draw(graphx.wall[1],tquad,((tx+1-camx)*48)+17-7,((ty+1-camy)*48)+(-18)-8,0,2,2)
				end
			if tilemap[ty][tx] == 0 then
				love.graphics.draw(graphx.floor[5],((tx+1-camx)*48)+17-7,((ty+1-camy)*48)+(-18)-8,0,2,2)
				end
			end
		end
	end
function drawObjsGRAPHIC(camx,camy)
	for i,o in ipairs(fObjs) do
		objDrawGRAPHIC(o,camx,camy)
		end
	for i,o in ipairs(iObjs) do
		objDrawGRAPHIC(o,camx,camy)
		end
	--objDrawGRAPHIC({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.5,1}},camx,camy)
	if localenemycount==0 then
		--objDrawGRAPHIC({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.7,1}},camx,camy,true)
		end
	for i,o in ipairs(eObjs) do
		objDrawGRAPHIC(o,camx,camy)
		end
	objDrawGRAPHIC(pObj,camx,camy)
	if controlmode==M_FIRING then
		--objDrawGRAPHIC({pox=cursorx,poy=cursory,char="X",color={0.5,0,0,1}},camx,camy,true)
		end
	end
function objDrawGRAPHIC(o,camx,camy,alwaysdraw)
	local isfobj = false
	if o.health==nil then isfobj = true end
	if alwaysdraw==nil then
		if o.health ~= nil and o.health<=0 then return end
		local stairtrackdist = 0
		if pObj.pox==exit.pox and pObj.poy==exit.poy and waitturns>0 and pBonus.stairtracking==true then stairtrackdist=99 end
		if revealall == true then stairtrackdist=99 end
		if distance(o.pox,o.poy,pObj.pox,pObj.poy)>pObj.viewdist+pBonus.trackdist+stairtrackdist then return end
		if o ~= pObj and distance(o.pox,o.poy,pObj.pox,pObj.poy)>pBonus.trackdist+stairtrackdist+1 then
			local rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,o.id)
			if rayhit.type ~= "obj" or rayhit.hit ~= o then
				rayhit = checkLOS(pObj.pox,pObj.poy,o.pox,o.poy,0,true,nil)
				if rayhit.type ~= "none" then
					return
					end
				end
			end
		end
	
	local sx,sy=((o.pox+1-camx)*48)+17-7,((o.poy+1-camy)*48)+(-18)-8
	love.graphics.setColor(o.color)
	if o.pox-camx>15 or o.poy-camy>8 or o.pox-camx<0 or o.poy-camy<0 then return end
	if isfobj==true and tilemap[o.poy][o.pox]==2 then--apparently this fucking explodes somehow but I'm too lazy to fix it rn so TODO: that lmao :3
		love.graphics.setColor(tilecolor[3][1],tilecolor[3][2],tilecolor[3][3],1)
		end
	
	if o.justfired==true and frames%10<5 then love.graphics.setColor(1,0.6,0,1) end
	if isfobj==true and tilemap[o.poy][o.pox]==1 then
		--love.graphics.print("#",sx,sy)
		else
		if o.graphic and graphx.obj[o.graphic] then
			love.graphics.draw(graphx.obj[o.graphic],sx,sy,0,2,2)
			else
			love.graphics.print(o.char,sx+12,sy+6)
			love.graphics.print("graphic missing",sx+6,sy+20)
			if o.graphic~=nil then love.graphics.print(o.graphic,sx+6,sy+34) else
				love.graphics.print("nil",sx+6,sy+34)
				end
			end
		end
	--love.graphics.print(camx..","..camy,sx+6,sy+6+15)
	end