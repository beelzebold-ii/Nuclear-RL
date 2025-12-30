--tables holding info about mods
mod_data = {
	
}
applied_mods = {
	"base.lua"
}

--table holding the environment for mod lua scripts
local mod_env = {
	math = math,
	string = string,
	musicfile = function(filename)
		filename = "content/mods/assets_"..filename
		return love.audio.newSource(filename,"stream")
		end,
	soundfile = function(filename)
		filename = "content/mods/assets_"..filename
		return love.audio.newSource(filename,"static")
		end,
	love = {audio = {newSource = love.audio.newSource}},
}

--functions for sanity checking various definitions in the mod
--returns a string saying what value is missing or incorrect, or nil if the definition is fine
function CheckEnemyDef(def)
	if type(def.char)~="string" then return "char" end
	if type(def.color)~="table" or #(def.color)~=4 then return "color" end
	if type(def.health)~="number" or def.health<1 then return "health" end
	if type(def.dice)~="number" or def.dice<1 then return "dice" end
	if type(def.sides)~="number" or def.sides<1 then return "sides" end
	if type(def.tohit)~="number" then return "tohit" end
	if type(def.shots)~="number" or def.shots<1 then return "shots" end
	if type(def.xp)~="number" or def.xp<0 then return "xp" end
	if type(def.movetime)~="number" or def.movetime<1 then return "movetime" end
	if type(def.cooldown)~="number" or def.cooldown<0 then return "cooldown" end
	if type(def.aggro)~="number" then return "aggro" end
	if type(def.range)~="number" or def.range<1 then return "range" end
	if type(def.name)~="string" then return "name" end
	if type(def.desc)~="string" then return "desc" end
	
	return nil
	end
function CheckItemDef(def)
	if type(def.char)~="string" then return "char" end
	if type(def.color)~="table" or #(def.color)~=4 then return "color" end
	if type(def.name)~="string" then return "name" end
	if type(def.desc)~="string" then return "desc" end
	
	if def.type=="weapon" then
		return CheckWeaponDef(def)
		end
	if def.type=="armour" then def.type = "armor" end --lol
	if def.type=="armor" then
		return CheckArmorDef(def)
		end
	
	return "type"
	end
function CheckWeaponDef(def)
	if type(def.dice)~="number" or def.dice<1 then return "dice" end
	if type(def.sides)~="number" or def.sides<1 then return "sides" end
	if type(def.tohit)~="number" then return "tohit" end
	
	if type(def.weaptype)~="string" then return "weaptype" end
	if not (def.weaptype=="sidearm" or def.weaptype=="rapid" or def.weaptype=="shotgun" or def.weaptype=="small" or def.weaptype=="medium" or def.weaptype=="large") then
		return "weaptype"
		end
	
	if type(def.ammotype)~="string" then return "ammotype" end
	if def.ammotype=="9mm" or def.ammotype=="12ga" or def.ammotype=="5mm" or def.ammotype=="7mm" or def.ammotype==".35" then
		if type(def.maxammo)~="number" or def.maxammo<1 then return "maxammo" end
	elseif def.ammotype~="no" then
		return "ammotype"
		end
	
	if type(def.atktime)~="number" or def.atktime<0 then return "atktime" end
	if def.ammotype~="no" and (type(def.reltime)~="number" or def.reltime<0) then return "reltime" end
	if type(def.range)~="number" or def.range<3 then def.range = 3 end
	if type(def.sound)~="string" then return "sound" end
	if type(def.dice)~="number" or def.dice<1 then return "dice" end
	
	if type(def.dmgtype)~="string" then return "dmgtype" end
	if def.dmgtype=="melee" then
		if type(def.chrgtime)~="number" then return "chrgtime" end
		if type(def.chrgbonus)~="table" or #(def.chrgbonus)~=3 then return "chrgbonus" end
		if type(def.charge)~="number" then return "charge" end
	elseif not (def.dmgtype=="bullet" or def.dmgtype=="spread") then
		return "dmgtype"
		end
	return nil
	end
function CheckArmorDef(def)
	if type(def.shortname)~="string" then return "shortname" end
	if type(def.maxdurability)~="number" or def.maxdurability<1 then return "maxdurability" end
	if type(def.protection)~="number" or def.protection<0 then return "protection" end
	if type(def.painfactor)~="number" or def.painfactor<0 then def.painfactor = 1.0 end
	if type(def.movetime)~="number" or def.movetime<0 then def.movetime = 1.0 end
	return nil
	end
function CheckSoundDef(def)
	--if def.TypeOf("Source") then return nil end
	if type(def)=="userdata" and def.typeOf and def:typeOf("Source") then return nil end
	return "invalid"
	end
function CheckLevelDef(def)
	if type(def.floor)~="number" or def.floor<1 then return "floor" end
	if type(def.layer)~="number" then def.layer = 1 end
	if type(def.name)~="string" then return "name" end
	if CheckSoundDef(def.music)~=nil then return "music" end
	if type(def.entrytext)~="string" then return "entrytext" end
	if type(def.calmtext)~="string" then return "calmtext" end
	--the only check I can be arsed to add for the level file itself is if it actually exists
	if type(def.filename)~="string" then return "filename" end
	def.filename = "content/mods/assets_"..def.filename
	if not love.filesystem.isFile(def.filename) then
		return "level file"
		end
	return nil
	end

function DoesEnemyExist(classname,mdat)
	return (
		(type(mdat.enemies)=="table" and type(mdat.items[classname])=="table") or
		type(objclasses[classname])=="table"
		)
	end
function DoesItemExist(classname,mdat)
	return (
		(type(mdat.items)=="table" and type(mdat.items[classname])=="table") or
		type(itemclasses[classname])=="table"
		)
	end

function CheckEnemyEntry(def,mdat)
	if type(def[1])=="string" then
		if not DoesEnemyExist(def[1],mdat) then return "classname" end
		else
		return "1"
		end
	if type(def[2])~="number" then return "2" end
	if type(def[3])~="number" or def[3]<1 then return "3" end
	return nil
	end
function CheckItemEntry(def,mdat)
	if type(def[1])=="string" then
		if not DoesItemExist(def[1],mdat) then return "classname" end
		else
		return "1"
		end
	if type(def[2])~="number" then return "2" end
	if type(def[3])~="number" or def[3]<1 then return "3" end
	if type(def[4])~="number" or def[4]<0 then return "4" end
	return nil
	end

--functions for loading/checking and applying mods
function LoadModData(filename)
	local filepath = "content/mods/"..filename
	
	--attempt to load our file
	local chunk,fail = love.filesystem.load(filepath,"t")
	if not chunk then
		mod_data[filename] = {err = "Lua script failed with parsing error",errdetail = fail}
		return
		end
	
	--limit its environment heavily
	setfenv(chunk,mod_env)
	
	--try to run our file; if it has a runtime error we'll catch it here
	local ok,value = pcall(chunk)
	--fail if our script had a runtime error
	if not ok then
		mod_data[filename] = {err = "Lua script failed with runtime error",errdetail = value}
		print(value)
		return
		end
	
	--ensure that necessary values are here or bail out
	if type(value)~="table" then
		mod_data[filename] = {err = "Lua script failed with return error",errdetail = "Return block not present or not of type \"table\""}
		return
		end
	if type(value.modinfo)~="string" then
		mod_data[filename] = {err = "Lua script failed with modinfo error",errdetail = "Modinfo not present or not of type \"string\""}
		return
		end
	
	--validate blocks and their contents
	local medicalitems = {
		bandage = true,
		painkiller = true,
		medikit = true,
		adrenaline = true,
		traumakit = true,
		combatstim = true
	}
	for k,v in pairs(value) do
		if k=="enemies" then
			for k2,v2 in pairs(v) do
				local valid = CheckEnemyDef(v2)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "enemies: "..k2.." property "..valid.." is missing or invalid"}
					return
					end
				end
			end
		if k=="items" then
			for k2,v2 in pairs(v) do
				if medicalitems[k2]==true then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "items: cannot overwrite "..k2.." as it is a medical item"}
					return
					end
				local valid = CheckItemDef(v2)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "items: "..k2.." property "..valid.." is missing or invalid"}
					return
					end
				end
			end
		if k=="enemyspawntable" then
			for k2,v2 in ipairs(v) do
				local valid = CheckEnemyEntry(v2,value)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "enemyspawntable: entry "..k2.." property "..valid.." missing or invalid"}
					return
					end
				end
			end
		if k=="itemspawntable" then
			for k2,v2 in ipairs(v) do
				local valid = CheckItemEntry(v2,value)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "itemspawntable: entry "..k2.." property "..valid.." missing or invalid"}
					return
					end
				end
			end
		if k=="soundfx" then
			for k2,v2 in pairs(v) do
				local valid = CheckSoundDef(v2)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "soundfx: "..k2.." isn't a valid soundfile()"}
					return
					end
				end
			end
		if k=="presetlevels" then
			for k2,v2 in ipairs(v) do
				local valid = CheckLevelDef(v2)
				if valid~=nil then
					mod_data[filename] = {err = "Mod failed with definition error",errdetail = "presetlevels: level["..k2.."] property "..valid.." is missing or invalid"}
					return
					end
				end
			end
		end
	
	mod_data[filename] = value
	return
	end

function ApplyModData()
	for _,mod_name in ipairs(applied_mods) do
		local mod = mod_data[mod_name]
		
		if mod.err==nil then
			if mod.clearenemytable==true then
				espawntable = {}
				end
			if mod.clearitemtable==true then
				ispawntable = {}
				ispawntablew = {}
				ispawntablea = {}
				ispawntablem = {}
				end
			if mod.clearlevels==true then
				presetlevels = {}
				end
			
			for k,v in pairs(mod) do
				
				if k=="enemies" then
					for classname,class in pairs(v) do
						objclasses[classname] = class
						end
					end
				
				if k=="items" then
					for classname,class in pairs(v) do
						itemclasses[classname] = class
						end
					end
				
				if k=="enemyspawntable" then
					for _,entry in ipairs(v) do
						table.insert(espawntable,entry)
						end
					end
				
				if k=="itemspawntable" then
					for _,entry in ipairs(v) do
						table.insert(ispawntable,entry)
						if entry[5]=="w" then
							table.insert(ispawntablew,entry)
							end
						if entry[5]=="a" then
							table.insert(ispawntablea,entry)
							end
						end
					end
				
				if k=="soundfx" then
					for sndname,entry in pairs(v) do
						sfx[sndname] = entry
						end
					end
				
				if k=="presetlevels" then
					for i,lvl in ipairs(v) do
						if presetlevels[lvl.floor]==nil then
							presetlevels[lvl.floor] = {}
							end
						presetlevels[lvl.floor][lvl.layer] = lvl
						end
					end
				
				end
			end
		
		end
	end