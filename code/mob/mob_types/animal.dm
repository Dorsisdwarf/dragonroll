/mob/player/npc/animal
	name = "animal"
	desc = "grrr"
	icon_state = "clown"
	icon = 'sprite/mob/animal.dmi'
	isMonster = TRUE
	var/isHostile = FALSE
	var/list/droppedItems = list()

/mob/player/npc/animal/New()
	actualIconState = icon_state
	..()
	spawn(1)
		if(isHostile)
			npcNature = NPCTYPE_AGGRESSIVE
			mobFaction = new/datum/faction/generic_hostile
		else
			mobFaction = new/datum/faction/wildlife

/mob/player/npc/animal/chicken
	name = "Chicken"
	desc = "You wonder where it came from."
	icon_state = "chicken_white"

/mob/player/npc/animal/chicken/New()
	icon_state = "chicken_[pick("brown","white","black")]"
	..()

/mob/player/npc/animal/fox
	name = "Fox"
	desc = "Smarter than most things."
	icon_state = "fox"

/mob/player/npc/animal/dog
	name = "Dog"
	desc = "Some call him \"Ian\""
	icon_state = "corgi"

/mob/player/npc/animal/dog/New()
	icon_state = pick("corgi","lisa","pug")
	..()

/mob/player/npc/animal/crab
	name = "Crab"
	desc = "Comes with six conveniently attached sticks."
	icon_state = "crab"

/mob/player/npc/animal/crab/New()
	icon_state = pick("evilcrab","crab")
	..()

/mob/player/npc/animal/cow
	name = "Cow"
	desc = "She likes to moo-ve it."
	icon_state = "cow"

/mob/player/npc/animal/bear
	name = "Bear"
	desc = "Smarter than the average."
	icon_state = "bear"
	isHostile = TRUE

/mob/player/npc/animal/bear/New()
	icon_state = pick("brownbear","bearfloor")
	..()

/mob/player/npc/animal/spider
	name = "Spider"
	desc = "Spins webs and climbs aquaducts."
	icon_state = "guard"
	isHostile = TRUE

/mob/player/npc/animal/spider/New()
	icon_state = pick("guard","hunter","nurse")
	..()

/mob/player/npc/animal/cat
	name = "Cat"
	desc = "Fond of fiddles and spoons."
	icon_state = "cat"

/mob/player/npc/animal/cat/New()
	icon_state = pick("cat","cat2")
	..()

/mob/player/npc/animal/bat
	name = "Bat"
	desc = "No men here."
	icon_state = "bat"

/mob/player/npc/animal/wasp
	name = "Wasp"
	desc = "Pollinates figs. And nightmares."
	icon_state = "wasp"
	isHostile = TRUE

/mob/player/npc/animal/deer
	name = "Deer"
	desc = "Neigh!."
	icon_state = "deer"