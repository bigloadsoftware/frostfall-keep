/* Beds
 * Contains:
 * 		Beds
 *		Roller beds
 */

/*
 * Beds
 */
/obj/structure/bed
	name = "bed"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "bed"
	icon = 'icons/fallout/objects/furniture/chairs_and_beds.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = TRUE
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	dir = EAST
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 2
	var/bolts = TRUE
	var/use_directionals = FALSE

/obj/structure/bed/Initialize()
	. = ..()
	UpdateDir()

/obj/structure/bed/examine(mob/user)
	. = ..()
	if(bolts)
		. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/bed/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/bed/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/bed/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/wrench) && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
	else
		return ..()

/obj/structure/bed/proc/UpdateDir()
	if(use_directionals)
		switch(dir)
			if(NORTH,SOUTH)
				buckle_lying = FALSE
			else
				buckle_lying = TRUE

// double beds

/obj/structure/bed/double
	name = "double bed"
	icon_state = "doublebed"
	var/base_icon = "doublebed"

/obj/structure/bed/double/post_buckle_mob(mob/living/M as mob)
	if(M.buckled == src)
		M.pixel_y = 13
		M.old_y = 13
	else
		M.pixel_y = 0
		M.old_y = 0

/*
 * Wooden beds and old beds - Use wood for low tech like Oasis and Legion. Old for ruins.
 */

/obj/structure/bed/wooden
	name = "wooden bed"
	desc = "Wooden frame with a mattress"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	icon_state = "bed_wood"
	max_integrity = 80

/obj/structure/bed/old
	name = "ancient bed"
	desc = "Filthy beyond belief."
	icon_state = "bed_dirty"
	max_integrity = 50

/obj/structure/bed/club
	name = "bed"
	desc = "A vibrant pink and purple mattress cast in a thick metal frame."
	icon_state = "bed_club"
	max_integrity = 150

// Obsolete
/obj/structure/bed/oldalt
	name = "ancient bed"
	desc = "Filthy beyond belief."
	icon_state = "bed_dirty"
	max_integrity = 50

/*
 * Roller beds
 */
/obj/structure/bed/roller
	name = "roller bed"
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "down"
	anchored = FALSE
	resistance_flags = NONE
	var/foldabletype = /obj/item/roller
	use_directionals = FALSE
	var/isFoldable = TRUE

/obj/structure/bed/roller/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = W
		if(R.loaded)
			to_chat(user, span_warning("You already have a roller bed docked!"))
			return

		if(has_buckled_mobs())
			if(buckled_mobs.len > 1)
				unbuckle_all_mobs()
				user.visible_message(span_notice("[user] unbuckles all creatures from [src]."))
			else
				user_unbuckle_mob(buckled_mobs[1],user)
		else
			R.loaded = src
			forceMove(R)
			user.visible_message("[user] collects [src].", span_notice("You collect [src]."))
		return 1
	else
		return ..()

/obj/structure/bed/roller/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr) && isFoldable)
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return 0
		if(has_buckled_mobs())
			return 0
		usr.visible_message("[usr] collapses \the [src.name].", span_notice("You collapse \the [src.name]."))
		var/obj/structure/bed/roller/B = new foldabletype(get_turf(src))
		usr.put_in_hands(B)
		qdel(src)

/obj/structure/bed/roller/post_buckle_mob(mob/living/M)
	density = TRUE
	icon_state = "up"
	M.pixel_y = initial(M.pixel_y)
/*
/obj/structure/bed/roller/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)
*/
/obj/structure/bed/roller/post_unbuckle_mob(mob/living/M)
	density = FALSE
	icon_state = "down"
	M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
	M.pixel_y = M.get_standard_pixel_y_offset(M.lying)

/obj/item/roller
	name = "roller bed"
	desc = "A collapsed roller bed that can be carried around."
	icon = 'icons/obj/rollerbed.dmi'
	var/unfoldabletype = /obj/structure/bed/roller
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL // No more excuses, stop getting blood everywhere

/obj/item/roller/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/roller/robo))
		var/obj/item/roller/robo/R = I
		if(R.loaded)
			to_chat(user, span_warning("[R] already has a roller bed loaded!"))
			return
		user.visible_message(span_notice("[user] loads [src]."), span_notice("You load [src] into [R]."))
		R.loaded = new/obj/structure/bed/roller(R)
		qdel(src) //"Load"
		return
	else
		return ..()

/obj/item/roller/attack_self(mob/user)
	deploy_roller(user, user.loc)

/obj/item/roller/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(target))
		deploy_roller(user, target)

/obj/item/roller/proc/deploy_roller(mob/user, atom/location)
	var/obj/structure/bed/roller/R = new unfoldabletype(location)
	R.add_fingerprint(user)
	qdel(src)

/obj/item/roller/robo //ROLLER ROBO DA!
	name = "roller bed dock"
	var/loaded = null

/obj/item/roller/robo/New()
	loaded = new /obj/structure/bed/roller(src)
	desc = "A collapsed roller bed that can be ejected for emergency use. Must be collected or replaced after use."
	..()

/obj/item/roller/robo/examine(mob/user)
	. = ..()
	. += "The dock is [loaded ? "loaded" : "empty"]."

/obj/item/roller/robo/deploy_roller(mob/user, atom/location)
	if(loaded)
		var/obj/structure/bed/roller/R = loaded
		R.forceMove(location)
		user.visible_message("[user] deploys [loaded].", span_notice("You deploy [loaded]."))
		loaded = null
	else
		to_chat(user, span_warning("The dock is empty!"))

//Dog bed

/obj/structure/bed/dogbed
	name = "dog bed"
	icon_state = "dogbed"
	desc = "A comfy-looking dog bed. You can even strap your pet in, in case the gravity turns off."
	anchored = FALSE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 10

/obj/structure/bed/dogbed/ian
	desc = "Ian's bed! Looks comfy."
	name = "Ian's bed"
	anchored = TRUE

/obj/structure/bed/dogbed/cayenne
	desc = "Seems kind of... fishy."
	name = "Cayenne's bed"
	anchored = TRUE

/obj/structure/bed/dogbed/renault
	desc = "Renault's bed! Looks comfy. A foxy person needs a foxy pet."
	name = "Renault's bed"
	anchored = TRUE

/obj/structure/bed/dogbed/runtime
	desc = "A comfy-looking cat bed. You can even strap your pet in, in case the gravity turns off."
	name = "Runtime's bed"
	anchored = TRUE

/obj/structure/bed/dogbed/proc/update_owner(mob/living/M)
	name = "[M]'s bed"
	desc = "[M]'s bed! Looks comfy."

/obj/structure/bed/dogbed/buckle_mob(mob/living/M, force, check_loc)
	. = ..()
	update_owner(M)

/obj/structure/bed/alien
	name = "resting contraption"
	desc = "This looks similar to contraptions from Earth. Could aliens be stealing our technology?"
	icon_state = "abed"

/obj/structure/bed/mattress
	name = "mattress"
	desc = "This is used to lie in, sleep in or strap on."
	icon_state = "mattress0"
	buildstacktype = /obj/item/stack/sheet/cloth
	buildstackamount = 1
//	decontool = /obj/item/wirecutters

/obj/structure/bed/mattress/pregame/New()
	..()
	icon_state = "mattress[rand(0,5)]"

/obj/structure/bed/roller/bedroll
	name = "bedroll"
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "bedroll"
	anchored = FALSE
	resistance_flags = NONE
	foldabletype = /obj/item/roller/bedroll
	use_directionals = FALSE

/obj/item/roller/bedroll
	name = "rolled bedroll"
	desc = "A collapsed bedroll that can be carried around."
	unfoldabletype = /obj/structure/bed/roller/bedroll
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "bedrollrolled"
	w_class = WEIGHT_CLASS_SMALL // So you don't have to struggle with it! Besides, bedrolls can get pretty small.

/obj/structure/bed/roller/bedroll/post_buckle_mob(mob/living/M)
	density = TRUE
	icon_state = "bedroll"
	M.pixel_y = initial(M.pixel_y)

/obj/structure/bed/roller/bedroll/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)

/obj/structure/bed/roller/bedroll/post_unbuckle_mob(mob/living/M)
	density = FALSE
	icon_state = "bedroll"
	M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
	M.pixel_y = M.get_standard_pixel_y_offset(M.lying)


/obj/structure/bed/roller/bodycart
	name = "bodycart"
	desc = "A cart made to carry bodies, dead or alive."
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "bodycartopen"
	anchored = FALSE
	resistance_flags = NONE
	foldabletype = /obj/item/roller/bodycart
	use_directionals = FALSE
	isFoldable = FALSE  // with false, this means that it can't be folded anymore
	drag_delay = 0 SECONDS  // this is the slowdown when you drag an obj

// More medieval stuff

/obj/item/roller/bodycart //Needs to be pulled faster, but not able to be picked up. idk how
	name = "bodycart"
	desc = "A cart made to carry bodies, dead or alive."
	unfoldabletype = /obj/structure/bed/roller/bodycart
	icon = 'icons/obj/rollerbed.dmi'
	icon_state = "bodycart"
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/structure/bed/roller/bodycart/post_buckle_mob(mob/living/M)
	density = TRUE
	icon_state = "bodycartopen"
	M.pixel_y = initial(M.pixel_y)

/obj/structure/bed/roller/bodycart/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)

/obj/structure/bed/roller/bodycart/post_unbuckle_mob(mob/living/M)
	density = FALSE
	icon_state = "bodycart"
	M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
	M.pixel_y = M.get_standard_pixel_y_offset(M.lying)

/obj/structure/bed/cot
	name = "cot"
	desc = "A cot made from crude material. Not very comfortable, but more comfy than sleeping on the hard ground."
	icon = 'modular_roguetown/misc/structure.dmi'
	icon_state = "shitbed"
	buildstacktype = /obj/item/stack/sheet/cloth
	buildstackamount = 1
