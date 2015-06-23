/obj/item/food
	name = "edible numnums"
	desc = "tastey!"
	icon = 'sprite/obj/food.dmi'
	var/cooked_icon_state
	var/cooked_name
	var/foodLevel = 2
	reagentSize = 25
	var/list/containedReagents = list(/datum/reagent/nutrients = 1)
	var/exp_granted_cooking = 1
	var/level_required_cooking = 1
	var/cooked = 0

/obj/item/food/New()
	..()
	for(var/a in containedReagents)
		var/datum/reagent/R = new a
		reagents.addliquid(R.id, containedReagents[a])

/obj/item/food/objFunction(var/mob/user)
	reagents.trans_to(user.reagents,reagents.maxvolume)
	spawn(5)
		user.refreshInterface()
	sdel(src)
