-- NOTE: THESE ARE ALL UNUSED
-- (except the medical items, for whatever reason I neglected to include those
-- in mod support so they're still defined in this file.)

itemclasses = {
	m99pis = {
	},
	baton = {
	},
	knife = {
	},
	sawnoff = {
	},
	sm40smg = {
	},
	ca12shotty = {
	},
	ch7pis = {
	},
	machete = {
	},
	knuckles = {
	},
	sn730rifle = {
	},
	z3rifle = {
	},
	--energy weapons
	--some of these aren't defined in the base mod so I'll leave them here just in case
	blaster = {
		type="weapon",
		name="Arc Pistol",
		dice=2,
		sides=4,
		maxammo=5,
		ammotype="en.",
		atktime=10,
		reltime=19,
		tohit=0.6,
		range=5,
		sound="batrifle",
		dmgtype="spread",
		weaptype="sidearm",
		pickupmsg="What a strange device.",
		desc="This experimental tech I can only assume is a pet project of Nuclear's. Fires small directed blasts of plasma. Feels like it might explode in my hand.",
		char="}",
		color={0.7,0.3,1.0,1}
	},
	plasrifle = {
		type="weapon",
		name="Arc Cannon",
		dice=3,
		sides=3,
		maxammo=10,
		ammotype="en.",
		atktime=4,
		reltime=28,
		tohit=0.3,
		range=3,
		sound="batrifle",
		dmgtype="spread",
		weaptype="rapid",
		pickupmsg="Is this thing even tested?",
		desc="This must be some weird evil shit Nuclear's been working on for some weird evil reason. Fires heavy, wide blasts of plasma, very fast. Kicks like a mule.",
		char="}",
		color={1.0,0.3,0.7,1}
	},
	sword = {
	},
	
	--new guns
	witchmag = {
	},
	mk23pis = {
	},
	huntrifle = {
	},
	bossrifle = {
	},
	autopis = {
	},
	
	--new superweapons
	--these are conventional firearms that are very rare and expensive but very effective if you find one
	magsmg = {
	},
	machinegun = {
	},
	autoshotty = {
	},
	supershotgun = {
	},
	ch9pis = {
	},
	g26rifle = {
	},
	
	secarm = {
	},
	riotarm = {
	},
	milarm = {
	},
	balarm = {
	},
	nrgarm = {
	},
	
	--new medical items
	painkiller = {
		type="pain",
		name="Painkillers",
		minheal=7,
		maxheal=9,
		stim=10,
		desc="Just a bottle of very fast acting painkillers. Will not save you in the middle of getting shot.",
		char="+",
		graphic="health",
		color={0.1,0.4,0.08}
	},
	adrenaline = {
		type="pain",
		name="Adrenaline",
		minheal=11,
		maxheal=18,
		stim=35,
		desc="Yep, that's the good stuff. May or may not be the over the counter kind. Really, I don't know. It'll do the trick, though.",
		char="+",
		graphic="health",
		color={0.15,0.8,0.35}
	},
	combatstim = {
		type="pain",
		name="Combat Stim",
		minheal=23,
		maxheal=30,
		stim=55,
		desc="These don't seem to be a commercial product, they're very vaguely labelled. Where did these even come from?",
		char="+",
		graphic="health",
		color={0.5,1.0,0.7}
	},
	bandage = {
		type="aid",
		name="Bandages",
		usetime=9,
		heal=5,
		pain=0,
		uses=5,
		desc="It's small a bandage roll. Quick and painless to apply.",
		char="+",
		graphic="health",
		color={0.9,0.5,0.5}
	},
	medikit = {
		type="aid",
		name="First Aid Kit",
		usetime=42,
		heal=10,
		pain=40,
		uses=4,
		desc="There's not much here, but the assortment is wide enough for all sorts of stuff. Unfortunately all the ways to effectively stop gunshot wounds hurt like hell.",
		char="+",
		graphic="health",
		color={0.75,0.3,0.225}
	},
	traumakit = {
		type="aid",
		name="Trauma Kit",
		usetime=80,
		heal=20,
		pain=75,
		uses=3,
		desc="This kit is for genuine field medics, those militia guys must have brought it in. Either way, without a field medic handy, this will be very slow and painful to use.",
		char="+",
		graphic="health",
		color={0.6,0.0,0.0}
	},
}

function inventoryItem(classname,count)
	local o = {}
	local c = itemclasses[classname]
	
	if c==nil then
		print("INVALID ITEM CLASS: \n"..classname)
		end
	
	o.type = c.type
	if o.type=="weapon" then
		o.ammo = count
		else
		if o.type=="armor" then
			o.durability = count
			else
			o.count = count
			end
		end
	o.name=c.name
	o.desc=c.desc
	o.pickupmsg=c.pickupmsg
	o.char=c.char
	o.graphic=c.graphic
	o.color=c.color
	local attributes = {
		weapon = function(o,c)
			o.dice=c.dice
			o.sides=c.sides
			o.maxammo=c.maxammo
			if count==nil then
				o.ammo=c.maxammo
				end
			o.ammotype=c.ammotype
			o.atktime=c.atktime
			o.reltime=c.reltime
			o.tohit=c.tohit
			o.range=c.range
			o.chrgtime=c.chrgtime
			o.chrgbonus=c.chrgbonus
			o.charge=c.charge
			o.sound=c.sound
			o.dmgtype=c.dmgtype
			o.weaptype=c.weaptype
			
			o.ammouse = c.ammouse
			o.shots = c.shots
			end,
		armor = function(o,c)
			o.maxdurability=c.maxdurability
			if count==nil then
				o.durability=c.maxdurability
				end
			o.movetime=c.movetime
			o.protection=c.protection
			o.painfactor=c.painfactor
			o.shortname=c.shortname
			end,
		pain = function(o,c)
			o.minheal = c.minheal
			o.maxheal = c.maxheal
			o.stim = c.stim
			end,
		aid = function(o,c)
			o.usetime = c.usetime
			o.heal = c.heal
			o.pain = c.pain
			o.uses = c.uses
			o.maxuses = c.uses
			end,
	}
	attributes[o.type](o,c)
	
	return o
	end
function makeItemObj(classname,count,ox,oy)
	print("made item obj")
	local ioat = objat(ox,oy,iObjs)
	if ioat~=-1 then
		return
		end
	local o={pox=ox,poy=oy,item=inventoryItem(classname,count)}
	o.char=o.item.char
	o.graphic=o.item.graphic
	o.color=o.item.color
	o.id=#iObjs+1
	table.insert(iObjs,o)
	end
function makeAmmoObj(ammotype,count,ox,oy)
	print("made item obj")
	local ioat = objat(ox,oy,iObjs)
	if ioat~=-1 then
		return
		end
	local ammocolors={a9mm={0.7,0.7,0.7,1},["a.35"]={0.7,0.7,0.3,1},a5mm={0.6,0.4,0.2,1},a7mm={0.9,0.7,0.2,1},a12ga={1,0.5,0.5,1}}
	local ammographic={a9mm="smallammo",["a.35"]="smallammo",a5mm="rifleammo",a7mm="rifleammo",a12ga="shellammo"}
	local o={pox=ox,poy=oy,item={type="ammo",name=ammotype.." ammo",ammotype=ammotype,amount=count,char="*",graphic=ammographic["a"..ammotype],color=ammocolors["a"..ammotype]}}
	o.char=o.item.char
	o.graphic=o.item.graphic
	o.color=o.item.color
	o.id=#iObjs+1
	table.insert(iObjs,o)
	end
