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
		dice=2,
		sides=3,
		chrgtime=0,
		chrgbonus={1,4,7},
		charge=4,
		ammotype="no",
		atktime=12,
		tohit=0.8,
		sound="melee",
		dmgtype="melee",
		weaptype="small",
		desc="It's just a baton. Pretty simple and reliable.",
		char="/",
		color={0.4,0.4,0.5,1}
	},
	knife = {
		type="weapon",
		name="Combat Knife",
		dice=4,
		sides=2,
		chrgtime=-2,
		chrgbonus={1,1,2},
		charge=2,
		ammotype="no",
		atktime=9,
		tohit=0.85,
		sound="melee",
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
		tohit=0.7,
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
		chrgtime=1,
		chrgbonus={3,5,7},
		charge=4,
		ammotype="no",
		atktime=11,
		tohit=0.6,
		sound="melee",
		dmgtype="melee",
		weaptype="medium",
		desc="The bigger blade. Excellent.",
		char="/",
		color={0.7,0.5,0.5,1}
	},
	knuckles = {
		type="weapon",
		name="Knuckleduster",
		dice=4,
		sides=3,
		chrgtime=-1,
		chrgbonus={2,4,8},
		charge=5,
		ammotype="no",
		atktime=11,
		tohit=0.6,
		sound="melee",
		dmgtype="melee",
		weaptype="medium",
		desc="A versatile melee weapon regulated in some places for its brutality. This one may be blunt, but do not underestimate it.",
		char="/",
		color={0.6,0.6,0.2,1}
	},
	sn730rifle = {
		type="weapon",
		name="SN730 Rifle",
		dice=5,
		sides=6,
		maxammo=30,
		ammotype="5mm",
		atktime=4,
		reltime=29,
		tohit=0.633,
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
		atktime=6,
		reltime=31,
		tohit=0.6,
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
		chrgtime=0,
		chrgbonus={1,1,2},
		charge=1,
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
	
	--new guns
	witchmag = {
		type="weapon",
		name="Magnum Revolver",
		dice=6,
		sides=3,
		maxammo=6,
		ammotype=".35",
		atktime=10,
		reltime=24,
		tohit=0.8,
		sound="pistol",
		dmgtype="bullet",
		weaptype="sidearm",
		desc="What an ancient firearm. Kicks like a mule, pretty reliably.",
		char="}",
		color={0.4,0.65,0.5,1}
	},
	mk23pis = {
		type="weapon",
		name="mk23 Handcannon",
		dice=3,
		sides=5,
		maxammo=9,
		ammotype=".35",
		atktime=10,
		reltime=18,
		tohit=0.7,
		sound="pistol",
		dmgtype="bullet",
		weaptype="sidearm",
		desc="This magnum pistol packs a lovely kick in an almost manageable package. Sadly not the most reliable, as the cartridge is a bit to hefty for the gun.",
		char="}",
		color={0.1,0.55,0.15,1}
	},
	huntrifle = {
		type="weapon",
		name="Hunting Rifle",
		dice=7,
		sides=4,
		maxammo=10,
		ammotype=".35",
		atktime=13,
		reltime=20,
		tohit=0.8,
		sound="rifle",
		dmgtype="bullet",
		weaptype="shotgun",
		desc="Nice. Make sure to do a spin with it when you work the lever.",
		char="}",
		color={0.2,0.6,0.6,1}
	},
	autopis = {
		type="weapon",
		name="sm-41 Micro-SMG",
		dice=2,
		sides=4,
		maxammo=20,
		ammotype="9mm",
		atktime=2,
		reltime=20,
		tohit=0.65,
		sound="pistol",
		dmgtype="bullet",
		weaptype="rapid",
		desc="What an odd little piece of junk. This crunched down version of the much better sm-40 is just downright uncontrollable. Fires too fast, if you can believe it.",
		char="}",
		color={0.3,0.3,0.45,1}
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
		movetime=1.25,
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
		movetime=1.15,
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
		movetime=1.6,
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
	
	--new medical items
	painkiller = {
		type="pain",
		name="Painkillers",
		minheal=6,
		maxheal=8,
		stim=10,
		desc="Just a bottle of very fast acting painkillers. Will not save you in the middle of getting shot.",
		char="+",
		color={0.1,0.4,0.08}
	},
	adrenaline = {
		type="pain",
		name="Adrenaline",
		minheal=11,
		maxheal=18,
		stim=45,
		desc="Yep, that's the good stuff. May or may not be the over the counter kind. Really, I don't know. It'll do the trick, though.",
		char="+",
		color={0.15,0.8,0.35}
	},
	combatstim = {
		type="pain",
		name="Combat Stim",
		minheal=23,
		maxheal=30,
		stim=100,
		desc="These don't seem to be a commercial product, they're very vaguely labelled. Where did these even come from?",
		char="+",
		color={0.5,1.0,0.7}
	},
	bandage = {
		type="aid",
		name="Bandages",
		usetime=9,
		heal=5,
		pain=0,
		uses=4,
		desc="It's small a bandage roll. Quick and painless to apply.",
		char="+",
		color={0.9,0.5,0.5}
	},
	medikit = {
		type="aid",
		name="First Aid Kit",
		usetime=12,
		heal=10,
		pain=20,
		uses=3,
		desc="There's not much here, but the assortment is wide enough for all sorts of stuff. Unfortunately all the ways to effectively stop gunshot wounds hurt like hell.",
		char="+",
		color={0.75,0.3,0.225}
	},
	traumakit = {
		type="aid",
		name="Trauma Kit",
		usetime=40,
		heal=20,
		pain=45,
		uses=2,
		desc="This kit is for genuine field medics, those militia guys must have brought it in. Either way, without a field medic handy, this will be very slow and painful to use.",
		char="+",
		color={0.6,0.0,0.0}
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
			o.chrgtime=c.chrgtime
			o.chrgbonus=c.chrgbonus
			o.charge=c.charge
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
	local o={pox=ox,poy=oy,item={type="ammo",name=ammotype.." ammo",ammotype=ammotype,amount=count,char="*",color=ammocolors["a"..ammotype]}}
	o.char=o.item.char
	o.color=o.item.color
	o.id=#iObjs+1
	table.insert(iObjs,o)
	end
