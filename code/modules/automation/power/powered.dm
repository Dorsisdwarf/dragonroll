/obj/structure/powered
	name = "powered structure"
	desc = "positively shocking"
	icon = 'sprite/obj/power.dmi'
	icon_state = "potato_cell"
	var/powerHeld = 0 // power currently in the object
	var/powerTransfer = FALSE // should the object share it's power with connected sources
	var/powerNeeded = 10 // power consumed per call
	var/powerMax = 255 // max power held
	var/powerShare = 0 // power shared per call
	var/powerMin = 100 // how much power must be charged before we start
	var/halfLife = 10
	var/timeSinceLastPower = 0
	var/powerOn = TRUE // is the obj powered on and consuming electricity
	var/powerConsuming = TRUE // consumes power
	var/list/connectedWire = list() // connected machines

/obj/structure/powered/New()
	..()
	spawn(5)
		globalMachines |= src
		powerOn = TRUE
		update()

//consumes energy, used in normal process
/obj/structure/powered/proc/consumePower(var/amount)
	powerHeld = max(0,powerHeld - amount)

//shares power with the given obj
/obj/structure/powered/proc/sharePower(var/amount,var/obj/structure/powered/where)
	if(powerHeld - amount >= 0)
		consumePower(amount)
		where.addPower(amount)

//adds power to the obj
/obj/structure/powered/proc/addPower(var/amount)
	powerHeld = min(powerMax,powerHeld + amount)
	timeSinceLastPower = 0

//drops power completely
/obj/structure/powered/proc/dropPower(var/amount)
	if(powerHeld - amount > 0)
		powerHeld -= amount
	else
		powerHeld = 0

//updates the powered item
/obj/structure/powered/proc/update()
	return

/obj/structure/powered/proc/process()
	timeSinceLastPower++
	if(powerConsuming)
		if(timeSinceLastPower >= halfLife)
			if(powerHeld > powerMin)
				if(powerNeeded > 0)
					consumePower(powerNeeded)
		//if(powerHeld <= 0 && powerNeeded > 0)
		//	powerOn = FALSE
	if(powerTransfer)
		for(var/obj/structure/powered/P in connectedWire)
			if(powerHeld > powerMin)
				if(P.powerHeld < powerMin)
					sharePower(powerShare,P)

//shows output on the powered item's vars
/obj/structure/powered/verb/debugPower()
	set name = "Debug Power Inf."
	set category = "Debug Verbs"
	set src in view(1)
	world << "<b>---------------------------</b>"
	world << "<b>Held</b>: [powerHeld]"
	world << "<b>Transferring</b>: [powerTransfer]"
	world << "<b>Min</b>: [powerMin]"
	world << "<b>Needed</b>: [powerNeeded]"
	world << "<b>Max</b>: [powerMax]"
	world << "<b>Shared</b>: [powerShare]"
	world << "<b>Consuming</b>: [powerConsuming]"
	world << "<b>On</b>: [powerOn]"
	world << "<b>---------------------------</b>"

//basic power structures
/obj/structure/powered/smes
	name = "Ancient Pillar"
	desc = "Coils upon coils of electricity."
	icon_state = "smes"
	powerTransfer = TRUE
	powerShare = 500
	powerNeeded = 50


/obj/structure/powered/smes/filled
	name = "Imbued Ancient Pillar"
	icon_state = "smesi"
	powerConsuming = FALSE
	powerHeld = 999999
	powerMax = 999999

/obj/structure/powered/wire
	name = "Mana-Tube"
	desc = "Thick, solid glass conduits, carrying flowing red essence."
	icon = 'sprite/obj/power_cond_heavy.dmi'
	icon_state = "node"
	powerTransfer = TRUE
	powerShare = 100
	powerHeld = 150 // have some buffer for electrical transfer
	powerNeeded = 0
	density = 0
	var/d1
	var/d2
	var/d3
	var/d4

/obj/structure/powered/wire/verb/reloadPower()
	set src in view(32)
	update()

/obj/structure/powered/wire/debugPower()
	..()
	world << "Dirs: [connectedWire.len]"
	world << "Dir1: [d1]"
	world << "Dir2: [d2]"
	world << "Dir3: [d3]"
	world << "Dir4: [d4]"
	world << "State: [icon_state]"
	for(var/A in connectedWire)
		world << "Con. Wire: [A]"

/obj/structure/powered/wire/update()
	var/list/dirBuild = list()
	var/list/cardinal = list(NORTH,SOUTH,EAST,WEST)
	var/turf/T
	var/counter
	for(counter = 1; counter <= cardinal.len; ++counter)
		var/C = cardinal[counter]
		T = get_step(src,C)
		if(T)
			var/obj/structure/powered/I = locate() in T
			if(I)
				dirBuild[I] = C
				connectedWire |= I
	counter = 1
	var/list/safeList = list()
	for(var/obj/structure/powered/R in dirBuild)
		safeList.Insert(counter,dirBuild[R])
		++counter
	if(dirBuild.len == 1)
		d1 = 0
		d2 = safeList[1]
	if(dirBuild.len == 2)
		d1 = safeList[1]
		d2 = safeList[2]
	if(dirBuild.len == 3)
		d1 = safeList[1]
		d2 = safeList[2]
		d3 = safeList[3]
	if(dirBuild.len == 4)
		d1 = safeList[1]
		d2 = safeList[2]
		d3 = safeList[3]
		d4 = safeList[4]
	var/string = ""
	if(dirBuild.len == 1 || dirBuild.len == 2)
		string = "[d1]-[d2]"
	if(dirBuild.len == 3)
		string = "[d1]-[d2]-[d3]"
	if(dirBuild.len == 4)
		string = "[d1]-[d2]-[d3]-[d4]"
	icon_state = string