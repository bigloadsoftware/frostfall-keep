/obj/machinery/door/poddoor/shutters //heavily buffed from the TG version, but can still be destroyed by NCR/Legion recruit rolesc
	gender = PLURAL
	name = "shutters"
	desc = "A set of ancient, rusted-over roller shutters. The panelling is badly cracked, and the insulation underneath is starting to flake.."
	icon = 'icons/obj/doors/shutters.dmi'
	layer = SHUTTER_LAYER
	closingLayer = SHUTTER_LAYER
	armor = ARMOR_VALUE_LIGHT
	damage_deflection = 26 //fragile, but will block weak melee weapons
	max_integrity = 200
	proj_resist = 16 //fragile, blocks .22s
	recipe_type = /datum/crafting_recipe/shutters/old

/obj/machinery/door/poddoor/shutters/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0

// The below shutters are the original ones from the TG codebase. They are remaining as "secure" shutters. If anyone wants to improve their animation, feel free.
// The original shutters are now shutters_old.dmi; copy the naming format of the files into new a new .dmi to add new shutters that work with the poddoor code for animating the doors.
// Originally, the shutters were reskins of blast doors. Eighty hits with the Cap's sabre to destroy one shutter is far too powerful considering shutters cannot be deconstructed (yet).
// If you're a mapper and want super strong shutter, use the 'old' ones.

/obj/machinery/door/poddoor/shutters/old //"old" only in code and sprite. In-game these should be brand new.
	name = "strong shutters"
	desc = "A plain grey security shutter, it looks to be moderately reinforced. Mag-locks keep the shutter securely in place."
	icon = 'icons/obj/doors/shutters_old.dmi'
	icon_state = "closed"
	armor = ARMOR_VALUE_LIGHT
	max_integrity = 350
	damage_deflection = 36 //stronger, will block most one-handed melee weapons
	proj_resist = 30 // will block weaker pistol/scattershot projectiles, though most faction weapons will get through

/obj/machinery/door/poddoor/shutters/old/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0

/obj/machinery/door/poddoor/shutters/portcullis
	name = "portcullis"
	desc = "A wall of metal bars with small gaps in between."
	icon = 'modular_roguetown/misc/portcullis.dmi'
	icon_state = "closed"
	armor = ARMOR_VALUE_HEAVY
	max_integrity = 350
	damage_deflection = 36 //stronger, will block most one-handed melee weapons
	proj_resist = 30 // will block weaker pistol/scattershot projectiles, though most faction weapons will get through
	opacity = 0
	glass = 1

/obj/machinery/door/poddoor/shutters/portcullis/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0

/obj/machinery/door/poddoor/shutters/gate
	name = "portcullis"
	desc = "A massive wooden gate reinforced with metal."
	icon = 'modular_roguetown/misc/woodgate.dmi'
	icon_state = "closed"
	armor = ARMOR_VALUE_HEAVY
	max_integrity = 350
	damage_deflection = 36 //stronger, will block most one-handed melee weapons
	proj_resist = 30 // will block weaker pistol/scattershot projectiles, though most faction weapons will get through

/obj/machinery/door/poddoor/shutters/gate/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0

// End of old shutter stuff. Credit for the old shutter sprites to TG.

/obj/machinery/door/poddoor/shutters/radiation
	name = "radiation shutters"
	desc = "Lead-lined shutters painted yellow with a radioactive hazard symbol on it. Blocks out most radiation"
	icon = 'icons/obj/doors/shutters_radiation.dmi'
	icon_state = "closed"
	rad_insulation = 0.2

/obj/machinery/door/poddoor/shutters/radiation/preopen
	icon_state = "open"
	density = FALSE
	opacity = 0
	rad_insulation = 1

/obj/machinery/door/poddoor/shutters/radiation/do_animate(animation)
	..()
	switch(animation)
		if("opening")
			rad_insulation = 1
		if("closing")
			rad_insulation = -0.5

// A 3x3 N2 SM setup won't irradiate you if you're behind the shutter at -0.9 insulation. If it starts to delam, it'll start irradiating you slowly. Keep the value between -0.1 to -0.9

/obj/machinery/door/poddoor/shutters/window
	name = "windowed shutters"
	desc = "Mechanical shutters that have a thick piece of ballistic glass in the middle, allowing you to see through the shutters at all times."
	icon = 'icons/obj/doors/shutters_window.dmi'
	icon_state = "closed"
	armor = ARMOR_VALUE_LIGHT
	max_integrity = 300
	damage_deflection = 26 // weaker against melee
	proj_resist = 28
	opacity = 0
	glass = 1
	recipe_type = /datum/crafting_recipe/shutters/window

/obj/machinery/door/poddoor/shutters/window/preopen
	icon_state = "open"
	density = FALSE
