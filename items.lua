itemclasses = {
	m99pis = {
		type="weapon",
		name="m99 Pistol",
		dice=4,
		sides=3,
		maxammo=12,
		ammotype="9mm",
		atktime=9,
		reltime=18,
		tohit=0.9,
		sound="pistol",
		dmgtype="bullet",
		weaptype="sidearm",
		desc="An old but very popular handgun. Accurate and reliable. It'll do the trick for now.",
		char="}",
		color={0.5,0.5,0.5,1}
	},
	baton = {
		type="weapon",
		name="Baton",
		dice=3,
		sides=2,
		ammotype="no",
		atktime=12,
		tohit=0.8,
		sound="pistol",
		dmgtype="melee",
		weaptype="small",
		desc="It's just a baton. Pretty simple and reliable.",
		char="/",
		color={0.4,0.4,0.5,1}
	},
	knife = {
		type="weapon",
		name="Combat Knife",
		dice=2,
		sides=4,
		ammotype="no",
		atktime=9,
		tohit=0.85,
		sound="pistol",
		dmgtype="melee",
		weaptype="small",
		desc="Blades have been around for centuries, but this one's mine.",
		char="/",
		color={0.6,0.6,0.7,1}
	},
	sawnoff = {
		type="weapon",
		name="Sawnoff Shotgun",
		dice=2,
		sides=4,
		maxammo=2,
		ammotype="12ga",
		atktime=3,
		reltime=14,
		tohit=0.7,
		range=4,
		sound="batrifle",
		dmgtype="spread",
		weaptype="sidearm",
		desc="A sawed-off double barreled shotgun. Very cheap, but rather ineffective.",
		char="}",
		color={0.7,0.5,0.45,1}
	},
	sm40smg = {
		type="weapon",
		name="sm-40 SMG",
		dice=3,
		sides=4,
		maxammo=30,
		ammotype="9mm",
		atktime=4,
		reltime=24,
		tohit=0.55,
		sound="submachine",
		dmgtype="bullet",
		weaptype="rapid",
		desc="The sm-40 fell out of style some time ago, mainly due to reliability issues. However, it's still a good gun in close range.",
		char="}",
		color={0.65,0.65,0.7,1}
	},
	ca12shotty = {
		type="weapon",
		name="CA12 Shotgun",
		dice=3,
		sides=4,
		maxammo=6,
		ammotype="12ga",
		atktime=12,
		reltime=25,
		tohit=0.65,
		range=7,
		sound="batrifle",
		dmgtype="spread",
		weaptype="shotgun",
		pickupmsg="Groovy.",
		desc="Ah, the beloved CA12 \"Whiplash\" pump-action shotgun. Groovy.",
		char="}",
		color={0.9,0.5,0.5,1}
	},
	ch7pis = {
		type="weapon",
		name="CH7 Pistol",
		dice=5,
		sides=4,
		maxammo=15,
		ammotype="9mm",
		atktime=9,
		reltime=18,
		tohit=0.9,
		sound="pistol",
		dmgtype="bullet",
		weaptype="sidearm",
		desc="The CH7 Handgun is a very popular military service pistol, and with good reason.",
		char="}",
		color={0.5,0.7,0.6,1}
	},
	machete = {
		type="weapon",
		name="Machete",
		dice=4,
		sides=4,
		ammotype="no",
		atktime=11,
		tohit=0.6,
		sound="pistol",
		dmgtype="melee",
		weaptype="medium",
		desc="The bigger blade. Excellent.",
		char="/",
		color={0.7,0.5,0.5,1}
	},
	sn730rifle = {
		type="weapon",
		name="SN730 Rifle",
		dice=5,
		sides=6,
		maxammo=30,
		ammotype="5mm",
		atktime=6,
		reltime=29,
		tohit=0.45,
		sound="rifle",
		dmgtype="bullet",
		weaptype="rapid",
		desc="Truly the bread and butter of any military operation.",
		char="}",
		color={0.4,0.4,0.8,1}
	},
	z3rifle = {
		type="weapon",
		name="z-3 Battlerifle",
		dice=7,
		sides=6,
		maxammo=20,
		ammotype="7mm",
		atktime=7,
		reltime=31,
		tohit=0.4,
		sound="batrifle",
		dmgtype="bullet",
		weaptype="rapid",
		pickupmsg="Hell yea.",
		desc="Firing scarily heavy bullets, the z-3 battle rifle is just what you need to go toe to toe with the biggest baddies out there.",
		char="}",
		color={0.9,0.8,0.5,1}
	},
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
		tohit=0.3 ,
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
		type="weapon",
		name="Arc Blade",
		dice=5,
		sides=4,
		ammotype="no",
		atktime=13,
		tohit=0.8,
		sound="pistol",
		dmgtype="melee",
		weaptype="medium",
		pickupmsg="Bzzzt.",
		desc="It resembles a machete, with a metal \"blade\" that lights up brightly along the edge and makes a horrid sound when you press the button in the grip.",
		char="/",
		color={0.7,0.3,1.0,1}
	},
	secarm = {
		type="armor",
		name="Security Armor",
		shortname="Sec Armor",
		maxdurability=60,
		protection=1,
		painfactor=0.9,
		movetime=1.0,
		desc="Lightweight security armor that will only really serve to stop small attacks. At least it lasts a while.",
		char="[",
		color={0.2,0.4,0.6,1}
	},
	riotarm = {
		type="armor",
		name="Riot Armor",
		shortname="Riot Armor",
		maxdurability=70,
		protection=2,
		painfactor=0.6,
		movetime=1.6,
		desc="A suit of riot armor that will stop a fair bit of those annoying bullets. It won't hold up long to any heavy fire.",
		char="[",
		color={0.7,0.7,0.7,1}
	},
	milarm = {
		type="armor",
		name="Militia Armor",
		shortname="Mil Armor",
		maxdurability=100,
		protection=3,
		painfactor=0.8,
		movetime=1.2,
		desc="Finally, some quality armor. Easy to move in hybrid armor that's likely to hold up to a lot of punishment.",
		char="[",
		color={0.2,0.6,0.2,1}
	},
	balarm = {
		type="armor",
		name="Ballistic Armor",
		shortname="Heavy Armor",
		maxdurability=150,
		protection=5,
		painfactor=0.4,
		movetime=1.7,
		pickupmsg="It's... REALLY heavy.",
		desc="This heavy ballistic armor is prepared for anything from a battle rifle round to a point-blank shotgun shell. Makes it rather hard to move, though...",
		char="[",
		color={0.1,0.2,0.1,1}
	},
	nrgarm = {
		type="armor",
		name="Energy Armor",
		shortname="En. Armor",
		maxdurability=170,
		protection=3,
		painfactor=0.4,
		movetime=1.0,
		pickupmsg="Glorious day it is!",
		desc="A chest mounted passive energy shield. Given Nuclear's track record, I don't think I wanna know what kind of radiation this'd pump into you... At least it'll last you ages.",
		char="[",
		color={0.6,0.4,0.9,1}
	},
}

function inventoryItem(classname,count)
	local o = {}
	local c = itemclasses[classname]
	
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
			o.sound=c.sound
			o.dmgtype=c.dmgtype
			o.weaptype=c.weaptype
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
	local ammocolors={a9mm={0.7,0.7,0.7,1},a5mm={0.6,0.4,0.2,1},a7mm={0.9,0.7,0.2,1},a12ga={1,0.5,0.5,1}}
	local o={pox=ox,poy=oy,item={type="ammo",name=ammotype.." ammo",ammotype=ammotype,amount=count,char="*",color=ammocolors["a"..ammotype]}}
	o.char=o.item.char
	o.color=o.item.color
	o.id=#iObjs+1
	table.insert(iObjs,o)
	end