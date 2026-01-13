--vectors: cardinals, then diagonals, for quick n hacky diagonal gating
local vectors = {
	{0,-1},	--N  = 1
	{1,0},	--E  = 2
	{0,1},	--S  = 4
	{-1,0},	--W  = 8
	{1,-1},	--NE = 16
	{1,1},	--SE = 32
	{-1,1},	--SW = 64
	{-1,-1}	--NW = 128
}
--important note: right-left bits = top-bottom vectors
local tilefrommask = {
	--GAH WHAT DO YOU MEAN LUA DOESN'T SUPPORT BINARY LITERALS!!!
	--anything not in this list will default to {0,0} (center tile)
	[0] = {6,2},--pillar
	[1] = {1,3},--ends
	[4] = {1,0},
	[2] = {0,1},
	[8] = {3,1},
	[5] = {1,2},--bars
	[10] = {2,1},
	[3] = {2,3},--L curves
	[6] = {2,2},
	[12] = {3,2},
	[9] = {3,3},
	[7] = {2,0},--T junctions
	[14] = {3,0},
	[13] = {0,2},
	[11] = {0,3},
	[15] = {1,1},--+ junction
	[38] = {4,0},--TL corner
	[76] = {5,0},--TR corner
	[19] = {4,2},--BL corner
	[137] = {5,2},--BR corner
	[55] = {4,1},--L edge
	[205] = {5,1},--R edge
	[155] = {6,1},--B edge
	[110] = {6,0},--T edge
}
function getWallTile(mapx,mapy)
	local mask = 0
	for i=1,4 do
		local tx = math.min(math.max(mapx+vectors[i][1],1),45)
		local ty = math.min(math.max(mapy+vectors[i][2],1),25)
		if tilemap[ty][tx] == 1 then
			mask = mask + (2^(i-1))
			end
		end
	local mask_cardinal = mask
	for i=5,8 do
		local tx = math.min(math.max(mapx+vectors[i][1],1),45)
		local ty = math.min(math.max(mapy+vectors[i][2],1),25)
		if tilemap[ty][tx] == 1 then
			if bit.band(mask_cardinal, (2^(i-5))+(2^((i-4)%4)) ) == (2^(i-5))+(2^((i-4)%4)) then
				mask = mask + (2^(i-1))
				end
			end
		end
	local atlaspos = tilefrommask[mask] or {0,0}
	return graphx.walltile[atlaspos[1]][atlaspos[2]]
	end