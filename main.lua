--global vars
gameversion = "0.5.0"
gamedate = "Sep 2, 2025"
--this only changes when the cfg format is altered!!!
gamecfgversion = "040"

frames=1

update = true
lasttimetaken = nil

gamestate=0
STATE_INTRO=	0
STATE_TITLE=	1
STATE_CONF=		2
STATE_KEYS=		3
STATE_BUTN=		4
STATE_SCORES=	5
STATE_START=	6
STATE_SKILL=	7
STATE_GAME=		8
STATE_INV=		9
STATE_MORE=		10
STATE_LVUP=		11
STATE_TRAIT=	12
STATE_EQUIP=	13
STATE_LOG=		14
STATE_MORTIS=	15

menuselect = 1
bindingkey = false
ammoselect = false

levelnum = 1
--this can be actual static tile data
--45x25
tilemap={
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
{1,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
{1,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,1},
{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
}
--more vars related to tiles
tilecolor={{0.2,0.15,0.15,1},{0.6,0.5,0.5,1},{0.2,0.9,0.2,1}}
tilechar={".","#","="}
--plain rendering canvas
tilecanvas=love.graphics.newCanvas(800,480)
--horizontally blurred here
horzblurcanvas=love.graphics.newCanvas(800,480)
--curved view is rendered here
--and so is the fully blurred pixels
screencanvas=love.graphics.newCanvas(800,480)

--gifcat!
gifcat = require("gifcat")

--real shit
require("classes")
require("player")
require("turns")
require("items")
require("levels")

fObjs={}
iObjs={}
exit={pox=0,poy=0}
eObjs={}
localenemycount = 0 --number of enemies in the current level
pObj={pox=23,poy=13,char="@",color={0.2,0.2,1,1},damage=0,maxdamage=25,pain=0,xp=0,lv=1,sp=0,regentime=0,
		viewdist=8.1,movetime=10,atktime=1.0,reltime=1.0,tohit=1.05,tohitbonus=0.05,pointblank=4,damagebonus=0,painfactor=1.0}
pscore = 0
--player shit
controlmode = 0
M_MOVE = 0
M_FIRING = 1

defaultnames = {"Niko","Clance","Chloe","Benny","Franziska","Kelsey","Via","Turner","Temmie","Zik","Len","Caroline","Sam","Tommy","Kornel","Taggart","Cass","Romy","Amy","Victor","Marisa","Ash","Ari","Nikki","Index","Dawn","Mira"}
playerName = defaultnames[love.math.random(1,#defaultnames)]
pclassnames = {"Field Officer","Detective","Independent Contractor","War Veteran"}
pclassnameshort = {"Officer","Detective","Freelance","Veteran"}
pclassdesc = {
	"You're just a plain cop. You know everything about Nuclear's misdeeds, and yet are powerless to do anything, even more so with your badge gone.",
	"As the (former) detective (formerly) on Nuclear's case, you know you have to do something to stop their reckless endangerment of earth.",
	"It's a lonely life as a freelance investigator, especially when the police want to silence your findings. Journalism is for cowards.",
	"You knew a guy who knew a guy, so you know all about the situation. And, you're pretty pissed about your life's new hard time limit. Thanks, Nuclear."
}
pclassstat = {
	"Defining trait: Vitality\nStart with sec armor\n ",
	"Defining trait: Accuracy\nStart with bare minimum\n ",
	"Defining trait: Speed\nStart with sawnoff shotgun\n ",
	"Defining trait: None\nStart with combat knife\nAnd nothing else."
}
pclassspec = {
	"Innately better in melee",
	"Innately faster to reload",
	"Innately better with shotguns",
	"Innately better with recoil"
}
playerClass = love.math.random(1,4)

-- Officer		- tanky, good in melee, starts with armor and a baton
-- Detective	- glass cannon, weak start but gains extra accuracy and innately reloads quickly
-- Freelancer	- fast, starts with a doubshotty but not much ammo, innately accurate with shotguns
-- Veteran		- weak and unspecialized, starts with just a combat knife and anger issues, innately better in rapid

gameskill = 1
skillnames = {"Firing Blanks","Radioactive","Schadenfreude","Goin' Nuclear!"}

-- spd 	- faster movetime and atktime multiplier 							- quicker movement and firing
-- acc 	- more tohit, more damagebonus 										- more reliable shots
-- vit 	- higher damage threshold, pain lasts less time 					- more resilient to damage
-- per 	- longer viewdist, more tohit bonus, longer pointblank distance 	- more capable at long range
pStats = {spd = 0,acc = 0,vit = 0,per = 0}

--all skills cap out at level 3, and require 1 + the current level points. 1 skillpoint per level up.
--first level is always weaker than the other two, third comes with a bonus.	- level 3 bonuses:
-- sidearmory - draw sidearms faster, hit more reliably							- sidearms always deal +2 damage
-- rapidfire  - less recoil (tohit debuff) with sustained rapid fire			- sustained fire has no damage debuff
-- steady aim - higher accuracy and damage when you aim before shots			- no pain dmg if your last action was waiting
-- shotgunner - slightly higher accuracy and reload speed with shotguns			- choke +2
-- dodgeball  - passive debuff against enemy hitrate, higher chance of dodging	- if hit while moving, no pain dmg
-- tracker    - spot enemies from further and hear them through walls			- see all enemies when you wait on the stairs
-- packrat    - carry more ammo/items and get pickups faster					- pick up items instantly, every 5th shot is free
-- slayer	  - wait faster when wielding melee weapons, more melee crit dmg	- melee kills heal
pSkills = {side = 0,rapid = 0,marks = 0,shot = 0,dodge = 0,track = 0,pack = 0,brute = 0}
pSkillOrder = {}

pBonus = {
	sidearmdraw = 1.0,sidearmdmgmin = 0,sidearmdmgbuff = 0,
	rpdrecoilfactor = 1.0,rpddmgdebuff = true,
	aimfactor = 1.0,aimdmg = 0,aimshield = false,
	shottohit = 1.0,shotreload = 1.0,shotchokebuff = 0,
	passivedodgerate = 0.0,activedodgerate = 0.1,dodgeshield = false,
	trackdist = 0,stairtracking = false,
	ammocapbuff = 0,invcapbuff = 0,pickupspeed = 1.0,freefifthshot = false,
	meleewaittimefactor = 1.0, meleecritbuff = 0, meleelifesteal = false
}

playerAmmo = {a9mm=50,a5mm=50,a7mm=0,a12ga=20,abattery=0}
playerInventory = {}
maxPlayerInventory = 6
playerWeapon = inventoryItem("sm40smg")
playerArmor = inventoryItem("secarm")

playerDodge = false

playerDead = false

waitturns = 0
fireturns = 0

shots = 1

--general gamestats
runtime = 0
enemies = 0
kills = 0

mortisinfo = {runtime=0,enemies=0,kills=0,score=0,level=0,floor=1,class=1,skill=1,pname="John Nuclear",skillsorder={},stats={spd=0,acc=0,vit=0,per=0},victory=false}
mortistxt = "placeholder mortem"

cursorx = 2
cursory = 2
altfiring = false

--screen replay buffer
--array of canvas,duration pairs
replayBuffer = {}
takescreenshot = false

--no more setting hudmessage directly (soon)
hudmessage = ""
msglog = {{"Game set!",0}}

hiscores = {}

require("assets")


config = {}
local json = require("json")

--main loop functions
function love.load()
	--framerate limiting
	min_dt = 1/60
	next_time = love.timer.getTime()
	
	--load or create config file
	if love.filesystem.getInfo("nrlcfg.json")==nil then
		local configf=love.filesystem.newFile("nrlcfg.json")
		print("init cfg file")
		end
	local configdat=love.filesystem.read("nrlcfg.json")
	print("get cfg file")
	
	if configdat then
		print("config loaded")
		config = json.decode(configdat)
		if config.cfgversion~=gamecfgversion then
			config = {sfx = 10,mus = 10,rbuf = 10,keybinds = {
				KEY_UP = 'up',KEY_RIGHT = 'right',KEY_DOWN = 'down',KEY_LEFT = 'left',
				KEY_WAIT = 'w',KEY_FIRE = 'f',KEY_RELOAD = 'r',KEY_MORE = 'm',
				KEY_INV = 'i',KEY_EQUIP = 'e',KEY_GET = 'g',KEY_LOG = 'l',KEY_GIF = 'f12'
				},cfgversion = "040"}
			print("cfg reset (version incorrect)")
			love.filesystem.write("nrlcfg.json",json.encode(config))
			end
		else
		config = {sfx = 10,mus = 10,rbuf = 10,keybinds = {
			KEY_UP = 'up',KEY_RIGHT = 'right',KEY_DOWN = 'down',KEY_LEFT = 'left',
			KEY_WAIT = 'w',KEY_FIRE = 'f',KEY_RELOAD = 'r',KEY_MORE = 'm',
			KEY_INV = 'i',KEY_EQUIP = 'e',KEY_GET = 'g',KEY_LOG = 'l',KEY_GIF = 'f12'
			},cfgversion = gamecfgversion}
		print("new default config created :3")
		love.filesystem.write("nrlcfg.json",json.encode(config))
		end
	
	updateVol()
	
	consolas = love.graphics.newFont("consola.ttf",20)
	title = love.graphics.newFont("consola.ttf",60)
	subtitle = love.graphics.newFont("consola.ttf",30)
	love.graphics.setFont(consolas)
	curveshader = love.graphics.newShader("curveshader.gl")
	horzblurshader = love.graphics.newShader("horzblur.gl")
	vertblurshader = love.graphics.newShader("vertblur.gl")
	
	gifcat.init()
	
	--mus.title:play()
	--updatescreen(1,1)
	--makeObj("pissecguard",3,4)
	--makeObj("secdog",3,6)
	--makeObj("smgtacguard",5,4)
	--makeObj("riflemilguard",7,4)
	--makeObj("mildog",7,6)
	--makeObj("gundrone",9,4)
	--makeObj("shockdrone",9,6)
	--makeObj("gunbot",11,4)
	--makeObj("protogunbot",11,6)
	--makeObj("eliteguard",13,4)
		
	camx,camy=1,1
	end
function love.draw()
	if gamestate >= STATE_GAME then
		if update==true then
			updatescreen(camx,camy)
			update = false
			end
		else
		if gamestate == STATE_INTRO then
			love.graphics.setCanvas(tilecanvas)
			love.graphics.clear(0,0,0,1)
			
			local introtxt = "Nuclear Inc. is a multi-trillion dollar \"clean\" nuclear energy company spanning across all of North America.  \n         \nIn a failed case of corporate espionage between rival companies, all that was uncovered were implications of tax fraud, and mass dumping of waste wherever they pleased.  \n          \nOf course, a police investigation soon followed, revealing much more terrifying experiments being conducted... that is, until somebody somewhere was paid off.  \n          \nThe lead detective was silenced, the outsourced freelancer framed for murder, and the investigation shut down.  \n               \n               \nNobody can save the continent from near certain destruction."
			
			love.graphics.setColor(1,0.2,0.2)
			if frames>30 then
				love.graphics.printf(string.sub(introtxt,1,math.floor((frames-30)/1.5)),60,30,680)
				end
			if frames>1140 and frames%60<30 then
				love.graphics.printf("Press any key.",0,400,800,"center")
				end
			love.graphics.setColor(1,1,1)
			
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
			else
			drawMenu()
			end
		end
	
	local scale = love.graphics.getHeight()/480
	xofs = (love.graphics.getWidth()-(800*scale))/2
	
	love.graphics.draw(screencanvas,xofs,0,0,scale,scale)
	
	--record to the replay buffer
	if takescreenshot==true then
		takescreenshot = false
		local rpbcanvas = love.graphics.newCanvas(800,480)
		love.graphics.setCanvas(rpbcanvas)
		love.graphics.draw(screencanvas,0,0)
		love.graphics.setCanvas()
		table.insert(replayBuffer,{rpbcanvas,lasttimetaken})
		end
	--clear excess buffer items if above the limit
	local buffertime = 0
	for k,v in ipairs(replayBuffer) do
		buffertime = buffertime + (v[2]/1)
		end
	if buffertime > config.rbuf*10 then
		table.remove(replayBuffer,1)
		end
	
	if love.window.getFullscreen()==false then
		love.graphics.print(love.timer.getFPS(),0,0)
		end
	
	--framerate limiting
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
		next_time = cur_time
		return
		end
	love.timer.sleep(next_time - cur_time)
	end
function love.update(dt)
	--framerate limiting
	next_time = next_time + min_dt
	
	frames=frames+1
	
	if frames%5==0 then
		update = true
		local acidbrightness=math.random()*0.75
		tilecolor[3][1]=acidbrightness
		tilecolor[3][3]=acidbrightness
		end
	end
--beware, here be spaghetti code

--drawing code
function drawMenu()
	love.graphics.setCanvas(tilecanvas)
	love.graphics.clear(0,0,0,1)
	
	love.graphics.setColor(0.2,1,0.2)
	love.graphics.setFont(title)
	love.graphics.printf("NUCLEAR",0,40,800,"center")
	love.graphics.setFont(subtitle)
	love.graphics.setColor(1,0.2,0.2)
	love.graphics.printf("RogueLike",0,80,800,"center")
	love.graphics.setFont(consolas)
	
	if gamestate==STATE_TITLE then
		local menuitems = {"New Game","Settings","High Scores","Exit"}
		
		for i=1,#menuitems do
			if menuselect==i then
				love.graphics.setColor(0.2,1,0.2)
				else
				love.graphics.setColor(1,0.2,0.2)
				end
			love.graphics.printf(menuitems[i],0,240+20*i,800,"center")
			end
		
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("NuclearRL v"..gameversion.."\n"..gamedate,20,420)
		end
	if gamestate>=STATE_CONF and gamestate<=STATE_BUTN then
		local menudef = {
			[STATE_CONF] = {
				{"sfx","vol","SFX Volume"},
				{"mus","vol","Music Volume"},
				{nil,"txt"," "},
				{STATE_KEYS,"mnu","Keybinds"},
				--{STATE_BUTN,"mnu","Gamepad Buttons"},
				{nil,"txt"," "},
				{"rbuf","num","Replay Buffer Size","sec"},
			},
			[STATE_KEYS] = {
				{nil,"txt","KEYBINDS"},
				{"KEY_UP","key","Move Up"},
				{"KEY_LEFT","key","Move Left"},
				{"KEY_RIGHT","key","Move Right"},
				{"KEY_DOWN","key","Move Down"},
				{"KEY_FIRE","key","Attack"},
				{"KEY_RELOAD","key","Reload"},
				{"KEY_WAIT","key","Wait/Aim"},
				{"KEY_INV","key","Inventory"},
				{"KEY_EQUIP","key","Equipment"},
				{"KEY_MORE","key","More Info"},
				{"KEY_LOG","key","Message Log"},
				{"KEY_GIF","key","Save Replay GIF"},
				{nil,"txt"," "},
				{STATE_CONF,"mnu","Back"}
			},
			[STATE_BUTN] = {
				{nil,"txt","GAMEPAD BUTTONS"},
				{"BTN_UP","btn","Move Up"},
				{"BTN_LEFT","btn","Move Left"},
				{"BTN_RIGHT","btn","Move Right"},
				{"BTN_DOWN","btn","Move Down"},
				{"BTN_FIRE","btn","Attack"},
				{"BTN_RELOAD","btn","Reload"},
				{"BTN_WAIT","btn","Wait/Aim"},
				{"BTN_INV","btn","Inventory"},
				{"BTN_EQUIP","btn","Equipment"},
				{"BTN_MORE","btn","More Info"},
				{nil,"txt"," "},
				{STATE_CONF,"mnu","Back"}
			},
		}
		local menuoptindx = {
			[STATE_CONF] = {1,2,4,6},
			[STATE_KEYS] = {2,3,4,5,6,7,8,9,10,11,12,13,15},
			[STATE_BUTN] = {2},
		}
		local confitems = menudef[gamestate]
		local optindx = menuoptindx[gamestate]
		
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print("NuclearRL v"..gameversion.."\n"..gamedate,20,420)
		
		for i=1,#confitems do
			local addtxt=""
			if optindx[menuselect]==i then
				love.graphics.setColor(0.2,1,0.2)
				addtxt=">"
				else
				love.graphics.setColor(1,0.2,0.2)
				end
			love.graphics.print(addtxt..confitems[i][3],220,90+20*i)
			if confitems[i][2]=="vol" then
				local volbar="[/////////////]"
				love.graphics.setColor(0.2,0.,0.)
				love.graphics.print(volbar,480,90+20*i)
				love.graphics.setColor(1,0.2,0.2)
				love.graphics.print(string.sub(volbar,1,config[confitems[i][1]]),480,90+20*i)
				end
			if confitems[i][2]=="num" then
				love.graphics.setColor(1,0.2,0.2)
				love.graphics.print(config[confitems[i][1]].." "..confitems[i][4],520,90+20*i)
				end
			if confitems[i][2]=="key" or confitems[i][2]=="btn" then
				if bindingkey==true and optindx[menuselect]==i then love.graphics.setColor(1,1,0.2) end
				love.graphics.print(string.upper(config.keybinds[confitems[i][1]]),480,90+20*i)
				end
			end
		end
	if gamestate==STATE_START then
		for i=1,4 do
			if menuselect==i then
				love.graphics.setColor(0.2,1,0.2)
				else
				love.graphics.setColor(1,0.2,0.2)
				end
			love.graphics.print(pclassnames[i],140,180+22*i)
			end
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.print(pclassstat[menuselect].."\n"..pclassspec[menuselect],400,200)
		love.graphics.printf(pclassdesc[menuselect].."\n \nYou have nothing to lose. Might as well go down swinging.",80,300,640)
		end
	if gamestate==STATE_SKILL then
		for i=1,4 do
			if menuselect==i then
				love.graphics.setColor(0.2,1,0.2)
				else
				love.graphics.setColor(1,0.2,0.2)
				end
			love.graphics.printf(skillnames[i],0,170+20*i,800,"center")
			end
		love.graphics.setColor(1,0.2,0.2)
		local skilldesc = {
			"Don't be fooled, just because this is the \"easy\" skill doesn't mean it won't kick your ass on a first go.",
			"Enemies are slightly more accurate and numerous. Damage numbers are much more serious, though items are slightly better.",
			"Be prepared to feel the burn of low ammo and high pain. Decent weaponry is scarce, enemies do not always drop theirs.",
			"This skill level isn't even remotely fair. I'm sure I don't need to tell you what that means."
		}
		--love.graphics.print(pclassstat[menuselect],400,200)
		love.graphics.printf(skilldesc[menuselect],80,280,640)
		end
	if gamestate==STATE_SCORES then
		for k,v in ipairs(hiscores) do
			if k<menuselect+12 and k>menuselect-1 then
				local i = k+1-menuselect
				love.graphics.setColor(0.2,0.2,1)
				love.graphics.printf("  "..v.pname.." - Lv"..v.level.." "..pclassnameshort[v.class],35,i*20+90,800)
				
				love.graphics.setColor(1,0.2,0.2)
				love.graphics.printf(skillnames[v.skill],10,i*20+90,800,"center")
				love.graphics.setColor(1,0.8,0.2)
				love.graphics.printf("Floor "..v.floor,-200,i*20+90,800,"right")
				love.graphics.setColor(0.2,1,0.2)
				love.graphics.printf(v.score,-95,i*20+90,800,"right")
				end
			end
		love.graphics.setColor(1,0,0)
		love.graphics.printf("[CTRL + SHIFT + DEL] - !!Delete highscores!!",0,400,800,"center")
		--scroll bar
		love.graphics.setColor(0.3,0.,0.)
		love.graphics.rectangle("fill",730,10,4,460)
		love.graphics.setColor(1,0.2,0.2)
		love.graphics.rectangle("fill",727,(menuselect-1)*(460/(#hiscores-11)) + 30,10,25)
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
	end

function drawworld(camx,camy)
	for ty=camy,camy+24 do
		for tx=camx,camx+44 do
			local brightness = 1
			local dist = distance(tx,ty,pObj.pox,pObj.poy)
			if dist > pObj.viewdist-1 then brightness = 0.7 end
			if dist > pObj.viewdist then brightness = 0.4 end
			if dist > pObj.viewdist+1 then brightness = 0 end
			
			local rayhit = checkLOS(pObj.pox,pObj.poy,tx,ty,-1,true)
			if rayhit.type~="none" then
				if rayhit.type=="error" or rayhit.hit.pox~=tx or rayhit.hit.poy~=ty then brightness = 0 end
				end
			
			--draw the tile at tx,ty
			tilecolor[tilemap[ty][tx]+1][4]=brightness
			love.graphics.setColor(tilecolor[tilemap[ty][tx]+1])
			love.graphics.print(tilechar[tilemap[ty][tx]+1],(tx*15)+50-7,(ty*15)+15-8)
			end
		end
	end
function drawObjs(camx,camy)
	foreach(fObjs,objDraw)
	foreach(iObjs,objDraw)
	objDraw({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.5,1}})
	if localenemycount==0 then
		objDraw({pox=exit.pox,poy=exit.poy,char=">",color={0.5,0.5,0.7,1}},true)
		end
	foreach(eObjs,objDraw)
	objDraw(pObj)
	if controlmode==M_FIRING then
		objDraw({pox=cursorx,poy=cursory,char="X",color={0.5,0,0,1}},true)
		end
	end
--actual function that draws individual objs
function objDraw(o,alwaysdraw)
	local isfobj = false
	if o.health==nil then isfobj = true end
	if alwaysdraw==nil then
		if o.health ~= nil and o.health<=0 then return end
		local stairtrackdist = 0
		if pObj.pox==exit.pox and pObj.poy==exit.poy and waitturns>0 and pBonus.stairtracking==true then stairtrackdist=99 end
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
			"\"The humanity! My gun is out of bullets!\"\n \nCarry more ammo and items, and pick things up faster.",
			"\"For guts and motherfucking glory.\"\n \nDeal bonus melee crit damage, take less time waiting with melee weapons equipped."
		}
		local legendarybuff = {
			"Deal +2 damage with sidearms.",
			"No damage debuff from rapidfire volleys.",
			"Feel no pain while waiting still.",
			"All shotguns have tighter choke.",
			"Feel no pain while running, successful dodges aim for you automatically.",
			"See all enemies while waiting on the exit.",
			"Get pickups instantly. Every fifth shot is free.",
			"Heal slightly on every melee kill."
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
	love.graphics.print(math.floor(pObj.damage/pObj.maxdamage*100).."% Damage",45,420)
	if pObj.pain>0 then
		love.graphics.setColor(0.5,0,0,1)
		love.graphics.print(math.floor(pObj.pain+0.5).."% Pain",45,450)
		love.graphics.setColor(0.2,0.2,1)
		end
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
		love.graphics.print("Weapon: "..playerWeapon.name.." ("..playerWeapon.dice.."d"..playerWeapon.sides.. (playerWeapon.dmgtype=="spread" and "x9)" or ")"),220,420)
		if playerWeapon.ammotype~="no" then
			love.graphics.print("  Ammo: "..playerWeapon.ammo.."/"..playerWeapon.maxammo.." ("..playerWeapon.ammotype..")",220,435)
			else
			love.graphics.print("  Ammo: N/A",220,435)
			end
		end
	--target
	love.graphics.setColor(1,0.2,0.2)
	if controlmode==M_FIRING then
		if objat(cursorx,cursory,eObjs)~=-1 then
			local target = objat(cursorx,cursory,eObjs)
			love.graphics.print("Target: "..eObjs[target].name,555,405)
			love.graphics.print("Health: "..math.floor((eObjs[target].health/eObjs[target].maxhealth)*100).."%",570,420)
			love.graphics.print(" [m]ore",570,435)
			else
			if objat(cursorx,cursory,iObjs)~=-1 then
				local target = iObjs[objat(cursorx,cursory,iObjs)].item
				love.graphics.print("Target:",555,405)
				love.graphics.print(target.name,570,420)
				if target.type=="ammo" then
					love.graphics.print("Count: "..target.amount,570,435)
					end
				if target.type=="weapon" then
					love.graphics.print("    ("..target.dice.."d"..target.sides.. (target.dmgtype=="spread" and "x9)" or ")"),570,435)
					if target.ammotype~="no" then
						love.graphics.print("Ammo: "..target.ammo.."/"..target.maxammo,570,450)
						end
					end
				if target.type=="armor" then
					love.graphics.print("Durability: "..math.floor(target.durability/target.maxdurability*100).."%",570,435)
					end
				else
				love.graphics.print("Target: NONE",555,405)
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
			
			if menuselect==i and ammoselect==false then
				love.graphics.setColor(0.2,1,0.2)
				end
			love.graphics.print(v.name..xtratxt,135,75+(i*15))
			love.graphics.setColor(1,0.2,0.2)
			end
		
		if ammoselect==false then
			love.graphics.print("AMMO",500,120)
			love.graphics.print("9mm  "..playerAmmo.a9mm,485,150)
			love.graphics.print("5mm  "..playerAmmo.a5mm,485,165)
			love.graphics.print("7mm  "..playerAmmo.a7mm,485,180)
			love.graphics.print("12ga "..playerAmmo.a12ga,485,195)
			local ammobulk = (playerAmmo.a9mm*2) + (playerAmmo.a5mm*2.5) + (playerAmmo.a7mm*3) + (playerAmmo.a12ga*4)
			love.graphics.print("CAPACITY",485,225)
			love.graphics.print(math.floor(ammobulk).."/"..200+pBonus.ammocapbuff,485,240)
			
			local itemsel = playerInventory[menuselect]
			if itemsel~=nil then
				love.graphics.print(itemsel.name,150,255)
				if itemsel.type=="weapon" then
					love.graphics.print("Damage: "..itemsel.dice.."d"..itemsel.sides.. (itemsel.dmgtype=="spread" and " x9" or ""),135,285)
					love.graphics.print("To Hit: "..itemsel.tohit,135,300)
					if itemsel.dmgtype=="spread" then
						love.graphics.print("Choke:  "..itemsel.range-1,135,315)
						love.graphics.printf(itemsel.desc,135,345,500)
						else
						love.graphics.printf(itemsel.desc,135,330,500)
						end
					if itemsel.ammotype~="no" then
						love.graphics.print("Reload time: "..itemsel.reltime/10 .."s",315,285)
						else
						love.graphics.print("Reload time: N/A",315,285)
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
			else
			local ammos = {"9mm  ","5mm  ","7mm  ","12ga "}
			local ammoid = {"9mm","5mm","7mm","12ga"}
			love.graphics.print("AMMO",500,120)
			for i=1,4 do
				if menuselect==i then
					love.graphics.setColor(0.2,1,0.2)
					end
				love.graphics.print(ammos[i]..playerAmmo["a"..ammoid[i]],485,135+(i*15))
				love.graphics.setColor(1,0.2,0.2)
				end
			local ammobulk = (playerAmmo.a9mm*2) + (playerAmmo.a5mm*2.5) + (playerAmmo.a7mm*3) + (playerAmmo.a12ga*4)
			love.graphics.print("CAPACITY",485,225)
			love.graphics.print(math.floor(ammobulk).."/"..200+pBonus.ammocapbuff,485,240)
			
			local ammodesc = {
				"The classic small size round. Lightweight but punchy. Not great against armor though.",
				"The 5mm rifle round is an excellent intermediate size cartridge capable of hurting \"real men\" real bad.",
				"Everyone loves to get the chance to use a full size battle rifle round. Hefty, but worth the weight.",
				"Ah, the beloved 12-gauge buckshot. Cheap, effective, and long tried and tested. Though, not the lightest ammo."
			}
			local ammoweight = {1,1.25,1.5,2}
			
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
		love.graphics.print("STATS",500,75)
		love.graphics.print("Total runtime: "..timerText(runtime/10),485,90)
		love.graphics.print("Kills: "..kills.."/"..enemies.." ("..localenemycount.." left)",485,105)
		if playerArmor==nil then
			love.graphics.print("Move time:   "..math.floor(pObj.movetime + 0.5)/10 .."s",485,135)
			else
			love.graphics.print("Move time:   "..math.floor(pObj.movetime * playerArmor.movetime + 0.5)/10 .."s",485,135)
			end
		if playerWeapon==nil then
			love.graphics.print("Fire time:   N/A",485,150)
			love.graphics.print("Reload time: N/A",485,165)
			else
			love.graphics.print("Fire time:   "..math.floor(playerWeapon.atktime * pObj.atktime + 0.5)/10 .."s",485,150)
			if playerWeapon.ammotype~="no" then
				love.graphics.print("Reload time: "..math.floor(playerWeapon.reltime * pObj.reltime + 0.5)/10 .."s",485,165)
				else
				love.graphics.print("Reload time: N/A",485,165)
				end
			end
		if (pObj.tohit-0.05)%1==0 then
			love.graphics.print("To Hit: "..pObj.tohit-0.05 ..".0x",485,195)
			else
			love.graphics.print("To Hit: "..pObj.tohit-0.05 .."x",485,195)
			end
		love.graphics.print("Bonus: +"..(pObj.tohitbonus+(math.min(waitturns,3)*0.1))*100-5 .."%",485,210)
		love.graphics.print("Difficulty:",485,240)
		local diffname = {"easy","normal","hard","hardest"}
		love.graphics.print(skillnames[gameskill].." ("..diffname[gameskill]..")",485,255)
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
				love.graphics.print("Damage: "..itemsel.dice.."d"..itemsel.sides.. (itemsel.dmgtype=="spread" and " x9" or ""),135,285)
				love.graphics.print("To Hit: "..itemsel.tohit,135,300)
				if itemsel.dmgtype=="spread" then
					love.graphics.print("Choke:  "..itemsel.range-1,135,315)
					love.graphics.printf(itemsel.desc,135,345,500)
					else
					love.graphics.printf(itemsel.desc,135,330,500)
					end
				if itemsel.ammotype~="no" then
					love.graphics.print("Reload time: "..itemsel.reltime/10 .."s",315,285)
					else
					love.graphics.print("Reload time: N/A",315,285)
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

--input handling
function love.keypressed(key,scancode,isrepeat)
	if key==config.keybinds.KEY_GIF and #replayBuffer>1 then
		createReplayGif()
		end
	
	if key=='return' and love.keyboard.isDown('lalt') then
		love.window.setFullscreen(not love.window.getFullscreen(),"desktop")
		return
		end
	
	if gamestate==STATE_INTRO then
		if not love.keyboard.isDown('lalt') then
			gamestate = STATE_TITLE
			mus.title:play()
			return
			end
		end
	if gamestate < STATE_GAME then
		if bindingkey==false then
			if key=='up' then
				if menuselect>1 then menuselect = menuselect - 1 end
				end
			if key=='down' then
				local maxsel = {4,4,13,11,math.max(1,#hiscores-12),4,4}
				if menuselect<maxsel[gamestate] then menuselect = menuselect + 1 end
				end
			end
		end
	if gamestate==STATE_TITLE and key=='return' then
		local mfunc = {
			function() --new
				gamestate = STATE_START
				menuselect = 1
				end,
			function() --settings
				gamestate = STATE_CONF
				menuselect = 1
				end,
			function() --scores
				gamestate = STATE_SCORES
				menuselect = 1
				loadHiscores()
				end,
			function() --exit
				love.event.quit()
				end
		}
		mfunc[menuselect]()
		return
		end
	if gamestate>=STATE_CONF and gamestate<=STATE_BUTN then
		if key=="escape" then
			if bindingkey==true then bindingkey=false else
				menuselect = 1
				gamestate = STATE_TITLE
				print("config file saved")
				love.filesystem.write("nrlcfg.json",json.encode(config))
				end
			return
			end
		local forbiddenkeys = {
			"lshift","rshift","numlock","capslock","scrolllock","lalt","ralt","lgui","rgui","printscreen","backspace"
		}
		for i=1,#forbiddenkeys do
			if key==forbiddenkeys[i] then
				return
				end
			end
		local menudefs = {
			[STATE_CONF] = {
				{"sfx","vol"},
				{"mus","vol"},
				{STATE_KEYS,"mnu"},
				--{STATE_BUTN,"mnu"},
				{"rbuf","vol"},
			},
			[STATE_KEYS] = {
				{"KEY_UP","key"},
				{"KEY_LEFT","key"},
				{"KEY_RIGHT","key"},
				{"KEY_DOWN","key"},
				{"KEY_FIRE","key"},
				{"KEY_RELOAD","key"},
				{"KEY_WAIT","key"},
				{"KEY_INV","key"},
				{"KEY_EQUIP","key"},
				{"KEY_MORE","key"},
				{"KEY_LOG","key"},
				{"KEY_GIF","key"},
				{STATE_CONF,"mnu"},
			},
			[STATE_BUTN] = {
				{"BTN_UP","btn"},
				{"BTN_LEFT","btn"},
				{"BTN_RIGHT","btn"},
				{"BTN_DOWN","btn"},
				{"BTN_FIRE","btn"},
				{"BTN_RELOAD","btn"},
				{"BTN_WAIT","btn"},
				{"BTN_INV","btn"},
				{"BTN_EQUIP","btn"},
				{"BTN_MORE","btn"},
				{STATE_CONF,"mnu"},
			},
		}
		local confitems = menudefs[gamestate]
		if confitems[menuselect][2]=="vol" then
			if key=="left" then
				config[confitems[menuselect][1]] = math.max(0,config[confitems[menuselect][1]]-1)
				end
			if key=="right" then
				config[confitems[menuselect][1]] = math.min(15,config[confitems[menuselect][1]]+1)
				end
			updateVol()
			end
		if confitems[menuselect][2]=="key" then
			if bindingkey==true then
				config.keybinds[confitems[menuselect][1]] = key
				bindingkey = false
				else
				if key=="return" then bindingkey=true end
				end
			end
		if confitems[menuselect][2]=="btn" then
			if bindingkey==true then
				bindingkey = false
				else
				if key=="return" then bindingkey=true end
				end
			end
		if confitems[menuselect][2]=="mnu" then
			if key=="return" then
				gamestate = confitems[menuselect][1]
				menuselect = 1
				end
			end
		end
	if gamestate==STATE_SCORES then
		if key=="escape" then
			menuselect = 1
			gamestate = STATE_TITLE
			return
			end
		if key=='delete' and love.keyboard.isDown('lshift') and love.keyboard.isDown('lctrl') then
			love.filesystem.remove("nrlhiscore.nrl")
			loadHiscores()
			end
		end
	if gamestate==STATE_START then
		if key=='return' then
			playerClass = menuselect
			local cfunc = {
				function()--officer
					playerAmmo = {a9mm=45,a5mm=0,a7mm=0,a12ga=0}
					playerInventory = {inventoryItem("baton")}
					playerWeapon = inventoryItem("m99pis")
					playerArmor = inventoryItem("secarm")
					
					pObj={pox=23,poy=13,char="@",color={0.2,0.2,1,1},damage=0,maxdamage=25,pain=0,xp=0,lv=1,sp=0,regentime=0,
						viewdist=8.1,movetime=10,atktime=1.0,reltime=1.0,tohit=1.05,tohitbonus=0.05,pointblank=4,damagebonus=0,painfactor=1.0}
					end,
				function()--detective
					playerAmmo = {a9mm=30,a5mm=0,a7mm=0,a12ga=0}
					playerInventory = {}
					playerWeapon = inventoryItem("m99pis")
					playerArmor = nil
					
					pObj={pox=23,poy=13,char="@",color={0.2,0.2,1,1},damage=0,maxdamage=25,pain=0,xp=0,lv=1,sp=0,regentime=0,
						viewdist=9.1,movetime=10,atktime=1.0,reltime=1.0,tohit=1.05,tohitbonus=0.1,pointblank=5,damagebonus=1,painfactor=1.0}
					end,
				function()--freelancer
					playerAmmo = {a9mm=0,a5mm=0,a7mm=0,a12ga=12}
					playerInventory = {}
					playerWeapon = inventoryItem("sawnoff")
					playerArmor = nil
					
					pObj={pox=23,poy=13,char="@",color={0.2,0.2,1,1},damage=0,maxdamage=25,pain=0,xp=0,lv=1,sp=0,regentime=0,
						viewdist=8.1,movetime=9,atktime=0.9,reltime=1.0,tohit=1.05,tohitbonus=0.05,pointblank=4,damagebonus=0,painfactor=1.0}
					end,
				function()--war vet
					playerAmmo = {a9mm=0,a5mm=0,a7mm=0,a12ga=0}
					playerInventory = {}
					playerWeapon = inventoryItem("knife")
					playerArmor = nil
					
					pObj={pox=23,poy=13,char="@",color={0.2,0.2,1,1},damage=0,maxdamage=25,pain=0,xp=0,lv=1,sp=0,regentime=0,
						viewdist=9.1,movetime=9,atktime=0.9,reltime=1.0,tohit=1.05,tohitbonus=0.05,pointblank=4,damagebonus=0,painfactor=0.9}
					end
			}
			
			cfunc[menuselect]()
			gamestate = STATE_SKILL
			menuselect = 2
			return
			end
		if key=='escape' then
			gamestate = STATE_TITLE
			menuselect = 1
			end
		end
	if gamestate==STATE_SKILL then
		if key=='return' then
			gameskill = menuselect
			startgame()
			end
		if key=='escape' then
			gamestate = STATE_START
			menuselect = 1
			end
		end
	
	if playerDead==true then
		if key=='return' then
			mortistxt=generateMortem(mortisinfo)
			local mortisf = love.filesystem.newFile("incidentreport_"..playerName.."-"..os.date("%m.%d.%Y").."-"..runtime..".txt")
			if mortisf:open('w')==true then
				mortisf:write(mortistxt)
				mortisf:close()
				end
			local hiscoredat = ""..
				string.char(mortisinfo.score%256)..
				string.char(math.floor(mortisinfo.score/256))..
				string.char(mortisinfo.level)..
				string.char(mortisinfo.floor)..
				string.char(mortisinfo.class)..
				string.char(mortisinfo.skill)..
				love.data.encode("string","base64",mortisinfo.pname)
			if love.filesystem.getInfo("nrlhiscore.nrl")~=nil then
				love.filesystem.append("nrlhiscore.nrl","\n"..hiscoredat)
				else
				local hiscoref = love.filesystem.newFile("nrlhiscore.nrl")
				if hiscoref:open('w') then
					hiscoref:write("nrlhiscore\n"..hiscoredat)
					hiscoref:close()
					end
				end
			gamestate = STATE_MORTIS
			playerDead = false
			lvmus["cluster"..muscluster][clustertrack]:stop()
			mus.death:play()
			menuselect = 1
			end
		return
		end
	if gamestate==STATE_MORTIS then
		if key=="escape" or key=="return" then
			menuselect = 1
			gamestate = STATE_TITLE
			mus.death:stop()
			mus.title:play()
			return
			end
		if key=="down" and menuselect<10 then
			menuselect = menuselect + 1
			end
		if key=="up" and menuselect>1 then
			menuselect = menuselect - 1
			end
		end
	
	if gamestate==STATE_MORE then
		if (key=='return' or key=='escape' or key=='m' or key=='up' or key=='left' or key=='right' or key=='down') then gamestate=STATE_GAME end
		return
		end
	if gamestate==STATE_INV then
		if key=='escape' or key=='i' then gamestate=STATE_GAME end
		if key=='up' then menuselect=math.max(1,menuselect-1) end
		if key=='down' then menuselect=math.min((ammoselect==true) and 4 or #playerInventory,menuselect+1) end
		if key=='right' then ammoselect = true;menuselect = 1 end
		if key=='left' then ammoselect = false;menuselect = 1 end
		if key=='return' and ammoselect==false then
			local itemsel = playerInventory[menuselect]
			if itemsel.type=="weapon" then
				if playerWeapon~=nil then
					table.insert(playerInventory,playerWeapon)
					end
				playerWeapon = itemsel
				local weaponswaptimes = {sidearm=10,rapid=26,shotgun=28,heavy=32,small=5,medium=16}
				local swaptime = weaponswaptimes[itemsel.weaptype]
				if itemsel.weaptype=="sidearm" then
					swaptime = swaptime * pBonus.sidearmdraw
					end
				playerturnend(swaptime*math.max(0.6,1.0 - pStats.spd * 0.05))
				table.remove(playerInventory,menuselect)
				if menuselect>#playerInventory then menuselect = #playerInventory end
				end
			if itemsel.type=="armor" then
				if playerArmor~=nil then
					table.insert(playerInventory,playerArmor)
					end
				playerArmor = itemsel
				playerturnend(45)
				table.remove(playerInventory,menuselect)
				if menuselect>#playerInventory then menuselect = #playerInventory end
				end
			end
		if key=='backspace' and ammoselect==false and #playerInventory>0 then
			local iat = objat(pObj.pox,pObj.poy,iObjs)
			if iat==-1 then
				local itemsel = playerInventory[menuselect]
				local i = {pox=pObj.pox,poy=pObj.poy,item=itemsel,color=itemsel.color,char=itemsel.char}
				table.insert(iObjs,i)
				table.remove(playerInventory,menuselect)
				else
				menuselect = 1
				mkHudmessage("There's no room to drop that here.")
				gamestate = STATE_GAME
				end
			end
		if key=='backspace' and ammoselect==true then
			local iat = objat(pObj.pox,pObj.poy,iObjs)
			if iat==-1 then
				local ammotypes = {"9mm","5mm","7mm","12ga"}
				local dropamt = {10,10,8,4}
				if playerAmmo["a"..ammotypes[menuselect]] > 0 then
					makeAmmoObj(ammotypes[menuselect],math.min(dropamt[menuselect],playerAmmo["a"..ammotypes[menuselect]]),pObj.pox,pObj.poy)
					playerAmmo["a"..ammotypes[menuselect]] = math.max(playerAmmo["a"..ammotypes[menuselect]]-dropamt[menuselect],0)
					end
				end
			end
		return
		end
	if gamestate==STATE_EQUIP then
		if key=='escape' or key=='e' then gamestate=STATE_GAME end
		if key=='up' then menuselect=math.max(1,menuselect-1) end
		if key=='down' then menuselect=math.min(2,menuselect+1) end
		if key=='return' then
			local equipment = {playerWeapon,playerArmor}
			local itemsel = equipment[menuselect]
			if itemsel~=nil then
				table.insert(playerInventory,itemsel)
				if menuselect==1 then playerWeapon = nil else playerArmor = nil end
				end
			end
		return
		end
	if gamestate==STATE_LVUP then
		if key=='up' then menuselect=math.max(1,menuselect-1) end
		if key=='down' then menuselect=math.min(4,menuselect+1) end
		if key=='return' then
			local statids = {"spd","acc","vit","per"}
			local lvup = {
				function()
					pObj.movetime = math.max(pObj.movetime - 1,6)
					pObj.atktime = math.max(pObj.atktime * 0.95,0.6)
					pObj.reltime = math.max(pObj.reltime - 0.1,0.5)
					end,
				function()
					pObj.damagebonus = pObj.damagebonus + 1
					pObj.tohit = pObj.tohit + 0.05
					end,
				function()
					--damage threshold increases by 1/4, but that increase is clamped between 8 and 17
					pObj.maxdamage = math.max(math.min(math.floor(pObj.maxdamage * 1.25),pObj.maxdamage + 14),pObj.maxdamage + 8)
					pObj.painfactor = pObj.painfactor * 0.85
					end,
				function()
					pObj.viewdist = pObj.viewdist + 1.2
					pObj.tohitbonus = pObj.tohitbonus + 0.065
					pObj.pointblank = pObj.pointblank + 1
					end
			}
			pStats[statids[menuselect]] = pStats[statids[menuselect]] + 1
			lvup[menuselect]()
			gamestate = STATE_TRAIT
			end
		return
		end
	if gamestate==STATE_TRAIT then
		if key=='up' then menuselect=math.max(1,menuselect-1) end
		if key=='down' then menuselect=math.min(9,menuselect+1) end
		if key=='return' then
			local statids = {"side","rapid","marks","shot","dodge","track","pack","brute"}
			local lvup = {
				function(slv)--side
					table.insert(pSkillOrder,"Side")
					if slv==0 then
						--first time basic upgrade
						pBonus.sidearmdraw = pBonus.sidearmdraw - 0.1
						pBonus.sidearmdmgmin = pBonus.sidearmdmgmin + 1
						else
						--standard upgrade
						pBonus.sidearmdraw = pBonus.sidearmdraw - 0.15
						pBonus.sidearmdmgmin = pBonus.sidearmdmgmin + 1
						if slv==2 then
							--max lv bonus
							pBonus.sidearmdmgbuff = 2
							end
						end
					end,
				function(slv)--rapid
					table.insert(pSkillOrder,"Rapid")
					if slv==0 then
						--first time basic upgrade
						pBonus.rpdrecoilfactor = pBonus.rpdrecoilfactor - 0.1
						else
						--standard upgrade
						pBonus.rpdrecoilfactor = pBonus.rpdrecoilfactor - 0.25
						if slv==2 then
							--max lv bonus
							pBonus.rpddmgdebuff = false
							end
						end
					end,
				function(slv)--marks
					table.insert(pSkillOrder,"Steady")
					if slv==0 then
						--first time basic upgrade
						pBonus.aimfactor = pBonus.aimfactor + 0.1
						pBonus.aimdmg = pBonus.aimdmg + 1
						else
						--standard upgrade
						pBonus.aimfactor = pBonus.aimfactor + 0.25
						pBonus.aimdmg = pBonus.aimdmg + 2
						if slv==2 then
							--max lv bonus
							pBonus.aimshield = true
							end
						end
					end,
				function(slv)--shot
					table.insert(pSkillOrder,"Shot")
					if slv==0 then
						--first time basic upgrade
						pBonus.shottohit = pBonus.shottohit + 0.03
						pBonus.shotreload = pBonus.shotreload - 0.05
						else
						--standard upgrade
						pBonus.shottohit = pBonus.shottohit + 0.1
						pBonus.shotreload = pBonus.shotreload - 0.15
						if slv==2 then
							--max lv bonus
							pBonus.shotchokebuff = 2
							end
						end
					end,
				function(slv)--dodge
					table.insert(pSkillOrder,"Dodge")
					if slv==0 then
						--first time basic upgrade
						pBonus.activedodgerate = pBonus.activedodgerate + 0.1
						else
						--standard upgrade
						pBonus.activedodgerate = pBonus.activedodgerate + 0.1
						pBonus.passivedodgerate = pBonus.passivedodgerate + 0.05
						if slv==2 then
							--max lv bonus
							pBonus.dodgeshield = true
							end
						end
					end,
				function(slv)--track
					table.insert(pSkillOrder,"Track")
					if slv==0 then
						--first time basic upgrade
						pBonus.trackdist = pBonus.trackdist + 1
						else
						--standard upgrade
						pBonus.trackdist = pBonus.trackdist + 2
						if slv==2 then
							--max lv bonus
							pBonus.stairtracking = true
							end
						end
					end,
				function(slv)--pack
					table.insert(pSkillOrder,"Pack")
					if slv==0 then
						--first time basic upgrade
						pBonus.ammocapbuff = pBonus.ammocapbuff + 20
						pBonus.invcapbuff = pBonus.invcapbuff + 1
						pBonus.pickupspeed = pBonus.pickupspeed - 0.15
						else
						--standard upgrade
						pBonus.ammocapbuff = pBonus.ammocapbuff + 50
						pBonus.invcapbuff = pBonus.invcapbuff + 1
						pBonus.pickupspeed = pBonus.pickupspeed - 0.25
						if slv==2 then
							--max lv bonus
							pBonus.freefifthshot = true
							pBonus.pickupspeed = 0.0
							end
						end
					end,
				function(slv)--slayer
					table.insert(pSkillOrder,"Slayer")
					if slv==0 then
						--first time basic upgrade
						pBonus.meleewaittimefactor = pBonus.meleewaittimefactor - 1/6
						pBonus.meleecritbuff = pBonus.meleecritbuff + 1
						else
						--standard upgrade
						pBonus.meleewaittimefactor = pBonus.meleewaittimefactor - 2/6
						pBonus.meleecritbuff = pBonus.meleecritbuff + 1
						if slv==2 then
							--max lv bonus
							pBonus.meleelifesteal = true
							end
						end
					end
			}
			if menuselect==9 then
				gamestate = STATE_GAME
				return
				end
			if pObj.sp>pSkills[statids[menuselect]] and pSkills[statids[menuselect]]<3 then
				pObj.sp = pObj.sp - (pSkills[statids[menuselect]] + 1)
				lvup[menuselect](pSkills[statids[menuselect]])
				pSkills[statids[menuselect]] = pSkills[statids[menuselect]] + 1
				else
				
				end
			end
		return
		end
	if gamestate==STATE_LOG then
		if key==config.keybinds.KEY_LOG or key=='escape' or key=='return' then
			gamestate = STATE_GAME
			menuselect = 1
			end
		if key=='up' then
			menuselect = math.min(math.max(#msglog-24,1),menuselect+1)
			end
		if key=='down' then
			menuselect = math.max(1,menuselect-1)
			end
		if key=='s' and love.keyboard.isDown('lshift') then
			saveMsglog(os.date("%m.%d.%Y").."-"..playerName)
			end
		end
	if gamestate==STATE_GAME then
		if key==config.keybinds.KEY_UP or key==config.keybinds.KEY_LEFT or key==config.keybinds.KEY_RIGHT or key==config.keybinds.KEY_DOWN then
			if controlmode==M_MOVE then playermove(key) end
			if controlmode==M_FIRING then cursormove(key) end
			end
		if key==config.keybinds.KEY_FIRE then
			if controlmode==M_FIRING then
				playerattack()
				else
				playeraim(love.keyboard.isDown('lshift'))
				end
			end
		if key==config.keybinds.KEY_RELOAD and playerWeapon~=nil and playerWeapon.ammotype~="no" and playerWeapon.ammo<playerWeapon.maxammo then
			tryplayerreload()
			end
		if key==config.keybinds.KEY_MORE and controlmode==M_FIRING and objat(cursorx,cursory,eObjs)~=-1 then
			gamestate=STATE_MORE
			moreobj=objat(cursorx,cursory,eObjs)
			end
		if key==config.keybinds.KEY_INV then	
			gamestate = STATE_INV
			menuselect = 1
			ammoselect = false
			end
		if key==config.keybinds.KEY_EQUIP then
			gamestate = STATE_EQUIP
			menuselect = 1
			end
		if key==config.keybinds.KEY_LOG then
			gamestate = STATE_LOG
			menuselect = 1
			end
		if key==config.keybinds.KEY_WAIT then
			playerwait()
			end
		if key=='escape' and controlmode==M_FIRING then
			controlmode=M_MOVE
			hudmessage=""
			end
		if key=='return' and pObj.pox==exit.pox and pObj.poy==exit.poy then
			levelnum = levelnum+1
			generatenewlevel(nil,true)
			end
		if key==config.keybinds.KEY_GET then
			local iat = objat(pObj.pox,pObj.poy,iObjs)
			if iat~=-1 then
				local itemget = iObjs[iat].item
				if itemget.type=="ammo" then
					local ammobulk = (playerAmmo.a9mm*2) + (playerAmmo.a5mm*2.5) + (playerAmmo.a7mm*3) + (playerAmmo.a12ga*4)
					local bulks = {a9mm=2,a5mm=2.5,a7mm=3,a12ga=4}
					
					if ammobulk + (bulks["a"..itemget.ammotype]*itemget.amount)>200+pBonus.ammocapbuff then
						mkHudmessage("I can't carry all this ammo!",{0.4,0.4,1,1})
						else
						playerAmmo["a"..itemget.ammotype] = playerAmmo["a"..itemget.ammotype] + itemget.amount
						iObjs[iat] = {pox=-1,poy=-1,char="",color={0,0,0,0}}
						mkHudmessage("Picked up "..itemget.amount.." "..itemget.name..".",{0.4,0.4,1,1})
						playerturnend(6*pBonus.pickupspeed,true)
						end
					else
					if #playerInventory<maxPlayerInventory+pBonus.invcapbuff then
						table.insert(playerInventory,itemget)
						iObjs[iat] = {pox=-1,poy=-1,char="",color={0,0,0,0}}
						mkHudmessage("Picked up the "..itemget.name..". ",{0.4,0.4,1,1})
						if itemget.pickupmsg~=nil then
							mkHudmessage(hudmessage..itemget.pickupmsg)
							end
						playerturnend(6*pBonus.pickupspeed,true)
						else
						mkHudmessage("I can't carry this!",{0.4,0.4,1,1})
						end
					end
				end
			end
		end
	update = true
	end

--general use functions (math, iterating, etc)
function foreach(t,f)
	for _,v in ipairs(t) do
		f(v)
		end
	end
function distance(x1,y1,x2,y2)
	return math.sqrt(((x1-x2)^2) + ((y1-y2)^2))
	end
function Set(list)
	local set = {}
	for k,l in ipairs(list) do set[l] = k end
	return set
	end

function timerText(timet)
	timet=math.max(timet,0)
	local strhrs = ""..math.floor((timet/60)/60)
	local strmins = ""..math.floor((timet/60)%60)
	local strsec = ""..math.floor(timet%60)
	if timet%60<10 then strsec="0"..strsec end
	if timet/60<10 and timet>3599 then strmins="0"..strmins end
	return (timet>3599 and strhrs..":" or "")..strmins..":"..strsec
	end

--for ray scans, they return a table containing member type (string identifier, "wall" or "obj") and a member hit (either contains the obj or
--the location of the hit if it hit a wall)
function checkLOS(x1,y1,x2,y2,onlyobj,exactrange,hitfloor)
	local maxraylength = 20
	
	local dx,dy
	dx=x2-x1
	dy=y2-y1
	local ox,oy
	ox=x1+0.5
	oy=y1+0.5
	
	local dist=math.sqrt((dx^2)+(dy^2))
	if exactrange==true then maxraylength = math.floor(dist) end
	
	if dist==0 then return {type="error",hit=nil} end
	
	dx=dx/dist
	dy=dy/dist
	if exactrange~=true and onlyobj==nil then print("LOS check:") end
	for i=1,maxraylength do
		if math.floor(oy+dy*i) < 1 or math.floor(oy+dy*i) > 25 or math.floor(ox+dx*i) < 1 or math.floor(ox+dx*i) > 45 then return {type="none",hit=nil} end
		local tile = tilemap[math.floor(oy+dy*i)][math.floor(ox+dx*i)]
		local obj = objat(math.floor(ox+dx*i),math.floor(oy+dy*i),eObjs)
		
		--if there's an object at this location then it blocks LOS and we should return it
		if obj~=-1 and eObjs[obj].health>0 and (onlyobj==obj or onlyobj==nil) then if exactrange~=true and onlyobj==nil then print("checkLOS obj: "..obj.."("..eObjs[obj].name..")") end;return {type="obj", hit=eObjs[obj]} end
		--if the tile at this location is a wall then it blocks LOS and we should return it
		if tile==1 then if exactrange~=true and onlyobj==nil then print("checkLOS wall: "..ox+dx*i..","..oy+dy*i) end;return {type="wall", hit={pox=math.floor(ox+dx*i),poy=math.floor(oy+dy*i)} } end
		
		--floor objects
		if hitfloor==true then
			local fobj = objat(math.floor(ox+dx*i),math.floor(oy+dy*i),fObjs)
			if fobj~=-1 and (onlyobj==fobj) then return {type="obj", hit=fObjs[fobj]} end
			end
		end
	if exactrange~=true and onlyobj==nil then print("unblocked!") end
	return {type="none",hit=nil}
	end
function hitscan(x1,y1,x2,y2,onlyobj)
	local maxraylength = 80
	
	local dx,dy
	dx=x2-x1
	dy=y2-y1
	local ox,oy
	ox=x1+0.5
	oy=y1+0.5
	
	local dist=math.sqrt((dx^2)+(dy^2))
	if exactrange==true then maxraylength = math.floor(dist) end
	
	if dist==0 then return {type="error",hit=nil} end
	
	dx=(dx/dist)*0.25
	dy=(dy/dist)*0.25
	for i=3,maxraylength,1 do
		if math.floor(oy+dy*i) < 1 or math.floor(oy+dy*i) > 25 or math.floor(ox+dx*i) < 1 or math.floor(ox+dx*i) > 45 then return {type="none",hit=nil} end
		local tile = tilemap[math.floor(oy+dy*i)][math.floor(ox+dx*i)]
		local obj = -1
		for k,v in ipairs(eObjs) do
			if v.pox==math.floor(ox+dx*i) and v.poy==math.floor(oy+dy*i) then
				obj = k
				end
			end
		
		--if there's an object at this location then it blocks LOS and we should return it
		if obj~=-1 and eObjs[obj].health>0 and (onlyobj==obj or onlyobj==nil) then return {type="obj", hit=eObjs[obj]} end
		--if the tile at this location is a wall then it blocks LOS and we should return it
		if tile==1 then return {type="wall", hit={pox=math.floor(ox+dx*i),poy=math.floor(oy+dy*i)} } end
		end
	return {type="none",hit=nil}
	end
function objat(ox,oy,otable)
	for i,o in ipairs(otable) do
		if o.pox==ox and o.poy==oy then
			if otable==eObjs and o.health<=0 then return -1 end
			return i
			end
		end
	return -1
	end

ignoreobj = 0
function makepathmap(fly)
	local pathmap = {}
	for x=1,45 do
		pathmap[x] = {}
		for y=1,25 do
			local thistile = true
			if tilemap[y][x] > 0 and (fly==false or tilemap[y][x]~=2) then thistile = false end
			
			local oat = objat(x,y,eObjs)
			if oat~=-1 and eObjs[oat]~=ignoreobj then thistile = false end
			
			pathmap[x][y] = thistile
			end
		end
	
	ignoreobj = 0
	return pathmap
	end

function mkHudmessage(txt,txcol)
	hudmessage = txt
	if txcol == nil then txcol = {1.0,1.0,1.0,0.65} end
	table.insert(msglog,{txt,runtime,txcol})
	if #msglog>200 then
		table.remove(msglog,1)
		end
	end
function saveMsglog(filename)
	local logf = love.filesystem.newFile(filename..".txt")
	if logf:open('w')==true then
		local logtxt = ""
		for k,v in ipairs(msglog) do
			logtxt = logtxt..timerText(v[2]/10).."> "..v[1].." \n"
			end
		logf:write(logtxt)
		logf:close()
		end
	end


function loadHiscores()
	hiscores = {}
	if love.filesystem.getInfo("nrlhiscore.nrl")~=nil then
		print("hiscore file found")
		local i = 1
		for line in love.filesystem.lines("nrlhiscore.nrl") do
			if i==1 then
				if line~="nrlhiscore" then
					print("err: header idstr fail")
					print(line)
					break
					end
				else
				--local hiscoredat = ""..
				--	string.char(mortisinfo.score%256)..
				--	string.char(math.floor(mortisinfo.score/256))..
				--	string.char(mortisinfo.level)..
				--	string.char(mortisinfo.floor)..
				--	string.char(mortisinfo.class)..
				--	string.char(mortisinfo.skill)..
				--	love.data.encode("string","base64",mortisinfo.pname)
				local hiscoredat = {
					score = string.byte(line,1)+(string.byte(line,2)*256),
					level = string.byte(line,3),
					floor = string.byte(line,4),
					class = string.byte(line,5),
					skill = string.byte(line,6),
					pname = love.data.decode("string","base64",string.sub(line,7,-1))
				}
				print("hiscore loaded for character "..hiscoredat.pname)
				print("lv"..hiscoredat.level.." class"..hiscoredat.class.." score"..hiscoredat.score)
				print("skill"..hiscoredat.skill)
				table.insert(hiscores,hiscoredat)
				end
			
			i = i+1
			end
		table.sort(hiscores,function(a,b)
			if a.score>b.score then return true else return false end
			end)
		else
		print("err: hiscore file not found")
		end
	end



function love.quit()
	gifcat.close()
	end