/datum/round_event_control/spacevine
	name = "Spacevine"
	typepath = /datum/round_event/spacevine
	weight = 15
	max_occurrences = 3
	min_players = 10

/datum/round_event/spacevine
	fakeable = FALSE

/datum/round_event/spacevine/start()
	var/list/turfs = list() //list of all the empty floor turfs in the hallway areas

	var/obj/structure/spacevine/SV = new()

	for(var/area/hallway/A in world)
		for(var/turf/F in A)
			if(F.Enter(SV))
				turfs += F

	qdel(SV)

	if(turfs.len) //Pick a turf to spawn at if we can
		var/turf/T = pick(turfs)
		new /datum/spacevine_controller(T, list(pick(subtypesof(/datum/spacevine_mutation))), rand(30,100), rand(5,10), src) //spawn a controller at turf with randomized stats and a single random mutation



/datum/spacevine_mutation
	var/name = ""
	var/severity = 1
	var/hue
	var/quality

/datum/spacevine_mutation/proc/add_mutation_to_vinepiece(obj/structure/spacevine/holder)
	holder.mutations |= src
	holder.add_atom_colour(hue, FIXED_COLOUR_PRIORITY)

/datum/spacevine_mutation/proc/process_mutation(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/process_temperature(obj/structure/spacevine/holder, temp, volume)
	return

/datum/spacevine_mutation/proc/on_birth(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_grow(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_death(obj/structure/spacevine/holder)
	return

/datum/spacevine_mutation/proc/on_hit(obj/structure/spacevine/holder, mob/hitter, obj/item/I, expected_damage)
	. = expected_damage

/datum/spacevine_mutation/proc/on_cross(obj/structure/spacevine/holder, mob/crosser)
	return

/datum/spacevine_mutation/proc/on_chem(obj/structure/spacevine/holder, datum/reagent/R)
	return

/datum/spacevine_mutation/proc/on_eat(obj/structure/spacevine/holder, mob/living/eater)
	return

/datum/spacevine_mutation/proc/on_spread(obj/structure/spacevine/holder, turf/target)
	return

/datum/spacevine_mutation/proc/on_buckle(obj/structure/spacevine/holder, mob/living/buckled)
	return

/datum/spacevine_mutation/proc/on_explosion(severity, target, obj/structure/spacevine/holder)
	return


/datum/spacevine_mutation/light
	name = "light"
	hue = "#ffff00"
	quality = POSITIVE
	severity = 4

/datum/spacevine_mutation/light/on_grow(obj/structure/spacevine/holder)
	if(holder.energy)
		holder.set_light(severity, 0.3)

/datum/spacevine_mutation/toxicity
	name = "toxic"
	hue = "#ff00ff"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/toxicity/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(issilicon(crosser))
		return
	if(prob(severity) && istype(crosser) && !isvineimmune(crosser))
		to_chat(crosser, span_alert("You accidentally touch the vine and feel a strange sensation."))
		crosser.adjustToxLoss(5)

/datum/spacevine_mutation/toxicity/on_eat(obj/structure/spacevine/holder, mob/living/eater)
	if(!isvineimmune(eater))
		eater.adjustToxLoss(5)

/datum/spacevine_mutation/explosive  //OH SHIT IT CAN CHAINREACT RUN!!!
	name = "explosive"
	hue = "#ff0000"
	quality = NEGATIVE
	severity = 2

/datum/spacevine_mutation/explosive/on_explosion(explosion_severity, target, obj/structure/spacevine/holder)
	if(explosion_severity < 3)
		qdel(holder)
	else
		. = 1
		QDEL_IN(holder, 5)

/datum/spacevine_mutation/explosive/on_death(obj/structure/spacevine/holder, mob/hitter, obj/item/I)
	explosion(holder.loc, 0, 0, severity, 0, 0)

/datum/spacevine_mutation/fire_proof
	name = "fire proof"
	hue = "#ff8888"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/fire_proof/process_temperature(obj/structure/spacevine/holder, temp, volume)
	return 1

/datum/spacevine_mutation/fire_proof/on_hit(obj/structure/spacevine/holder, mob/hitter, obj/item/I, expected_damage)
	if(I && I.damtype == "fire")
		. = 0
	else
		. = expected_damage

/datum/spacevine_mutation/vine_eating
	name = "vine eating"
	hue = "#ff7700"
	quality = MINOR_NEGATIVE

/datum/spacevine_mutation/vine_eating/on_spread(obj/structure/spacevine/holder, turf/target)
	var/obj/structure/spacevine/prey = locate() in target
	if(prey && !prey.mutations.Find(src))  //Eat all vines that are not of the same origin
		qdel(prey)

/datum/spacevine_mutation/aggressive_spread  //very OP, but im out of other ideas currently
	name = "aggressive spreading"
	hue = "#333333"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/aggressive_spread/on_spread(obj/structure/spacevine/holder, turf/target)
	target.ex_act(severity, null, src) // vine immunity handled at /mob/ex_act

/datum/spacevine_mutation/aggressive_spread/on_buckle(obj/structure/spacevine/holder, mob/living/buckled)
	buckled.ex_act(severity, null, src)

/datum/spacevine_mutation/transparency
	name = "transparent"
	hue = ""
	quality = POSITIVE

/datum/spacevine_mutation/transparency/on_grow(obj/structure/spacevine/holder)
	holder.set_opacity(0)
	holder.alpha = 125

/datum/spacevine_mutation/oxy_eater
	name = "oxygen consuming"
	hue = "#ffff88"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/oxy_eater/process_mutation(obj/structure/spacevine/holder)
	var/turf/open/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.set_moles(GAS_O2, max(GM.get_moles(GAS_O2) - severity * holder.energy, 0))

/datum/spacevine_mutation/nitro_eater
	name = "nitrogen consuming"
	hue = "#8888ff"
	severity = 3
	quality = NEGATIVE

/datum/spacevine_mutation/nitro_eater/process_mutation(obj/structure/spacevine/holder)
	var/turf/open/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.set_moles(GAS_N2, max(GM.get_moles(GAS_N2) - severity * holder.energy, 0))

/datum/spacevine_mutation/carbondioxide_eater
	name = "CO2 consuming"
	hue = "#00ffff"
	severity = 3
	quality = POSITIVE

/datum/spacevine_mutation/carbondioxide_eater/process_mutation(obj/structure/spacevine/holder)
	var/turf/open/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.set_moles(GAS_CO2, max(GM.get_moles(GAS_CO2) - severity * holder.energy, 0))

/datum/spacevine_mutation/plasma_eater
	name = "toxins consuming"
	hue = "#ffbbff"
	severity = 3
	quality = POSITIVE

/datum/spacevine_mutation/plasma_eater/process_mutation(obj/structure/spacevine/holder)
	var/turf/open/floor/T = holder.loc
	if(istype(T))
		var/datum/gas_mixture/GM = T.air
		GM.set_moles(GAS_PLASMA, max(GM.get_moles(GAS_PLASMA) - severity * holder.energy, 0))

/datum/spacevine_mutation/thorns
	name = "thorny"
	hue = "#666666"
	severity = 10
	quality = NEGATIVE

/datum/spacevine_mutation/thorns/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(prob(severity) && istype(crosser) && !isvineimmune(crosser))
		var/mob/living/M = crosser
		M.adjustBruteLoss(5)
		to_chat(M, span_alert("You cut yourself on the thorny vines."))

/datum/spacevine_mutation/thorns/on_hit(obj/structure/spacevine/holder, mob/living/hitter, obj/item/I, expected_damage)
	if(prob(severity) && istype(hitter) && !isvineimmune(hitter))
		var/mob/living/M = hitter
		M.adjustBruteLoss(5)
		to_chat(M, span_alert("You cut yourself on the thorny vines."))
	. =	expected_damage

/datum/spacevine_mutation/woodening
	name = "hardened"
	hue = "#997700"
	quality = NEGATIVE

/datum/spacevine_mutation/woodening/on_grow(obj/structure/spacevine/holder)
	if(holder.energy)
		holder.density = TRUE
	holder.max_integrity = 100
	holder.obj_integrity = holder.max_integrity

/datum/spacevine_mutation/woodening/on_hit(obj/structure/spacevine/holder, mob/living/hitter, obj/item/I, expected_damage)
	if(I?.get_sharpness())
		. = expected_damage * 0.5
	else
		. = expected_damage

/datum/spacevine_mutation/flowering
	name = "flowering"
	hue = "#0A480D"
	quality = NEGATIVE
	severity = 10

/datum/spacevine_mutation/flowering/on_grow(obj/structure/spacevine/holder)
	if(holder.energy == 2 && prob(severity) && !locate(/obj/structure/alien/resin/flower_bud_enemy) in range(5,holder))
		new/obj/structure/alien/resin/flower_bud_enemy(get_turf(holder))

/datum/spacevine_mutation/flowering/on_cross(obj/structure/spacevine/holder, mob/living/crosser)
	if(prob(25))
		holder.entangle(crosser)


// SPACE VINES (Note that this code is very similar to Biomass code)
/obj/structure/spacevine
	name = "ivy"
	desc = "An extremely expansionistic species of vine."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Light1"
	anchored = TRUE
	density = FALSE
	layer = SPACEVINE_LAYER
	mouse_opacity = MOUSE_OPACITY_OPAQUE //Clicking anywhere on the turf is good enough
	pass_flags = PASSTABLE | PASSGRILLE
	max_integrity = 50
	var/energy = 0
	var/datum/spacevine_controller/master = null
	var/list/mutations = list()

/obj/structure/spacevine/Initialize()
	. = ..()
	add_atom_colour("#ffffff", FIXED_COLOUR_PRIORITY)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)


/obj/structure/spacevine/examine(mob/user)
	. = ..()
	var/text = "This one is a"
	if(mutations.len)
		for(var/A in mutations)
			var/datum/spacevine_mutation/SM = A
			text += " [SM.name]"
	else
		text += " normal"
	text += " vine."
	. += text


/obj/structure/spacevine/proc/on_chem_effect(datum/reagent/R)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.on_chem(src, R)
	if(!override && istype(R, /datum/reagent/toxin/plantbgone))
		if(prob(50))
			qdel(src)

/obj/structure/spacevine/proc/eat(mob/eater)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.on_eat(src, eater)
	if(!override)
		qdel(src)

/obj/structure/spacevine/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1)
	var/damage_dealt = I.force * damage_multiplier
	if(I.get_sharpness())
		damage_dealt *= 4
	if(I.damtype == BURN)
		damage_dealt *= 4
	user.DelayNextAction()
	for(var/datum/spacevine_mutation/SM in mutations)
		damage_dealt = SM.on_hit(src, user, I, damage_dealt) //on_hit now takes override damage as arg and returns new value for other mutations to permutate further
	take_damage(damage_dealt, I.damtype, "melee", 1, attacked_by = user)

/obj/structure/spacevine/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/weapons/slash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/spacevine/proc/on_entered(atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_cross(src, AM)


/obj/structure/spacevine/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_hit(src, user)
	user_unbuckle_mob(user, user)
	. = ..()

/obj/structure/spacevine/attack_paw(mob/living/user)
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_hit(src, user)
	user_unbuckle_mob(user,user)
	return ..()

/obj/structure/spacevine/attack_alien(mob/living/user)
	eat(user)

/datum/spacevine_controller
	var/list/obj/structure/spacevine/vines
	var/list/growth_queue
	var/spread_multiplier = 5
	var/spread_cap = 30
	var/list/vine_mutations_list
	var/mutativeness = 1

/datum/spacevine_controller/New(turf/location, list/muts, potency, production, datum/round_event/event = null)
	vines = list()
	growth_queue = list()
	var/obj/structure/spacevine/SV = spawn_spacevine_piece(location, null, muts)
	if (event)
		event.announce_to_ghosts(SV)
	START_PROCESSING(SSobj, src)
	vine_mutations_list = list()
	init_subtypes(/datum/spacevine_mutation/, vine_mutations_list)
	if(potency != null)
		mutativeness = potency / 10
	if(production != null)
		spread_cap *= production / 5
		spread_multiplier /= production / 5

/datum/spacevine_controller/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SPACEVINE_PURGE, "Delete Vines")

/datum/spacevine_controller/vv_do_topic(href_list)
	. = ..()
	if(href_list[VV_HK_SPACEVINE_PURGE])
		if(alert(usr, "Are you sure you want to delete this spacevine cluster?", "Delete Vines", "Yes", "No") == "Yes")
			DeleteVines()

/datum/spacevine_controller/proc/DeleteVines()	//this is kill
	QDEL_LIST(vines)	//this will also qdel us

/datum/spacevine_controller/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/spacevine_controller/proc/spawn_spacevine_piece(turf/location, obj/structure/spacevine/parent, list/muts)
	var/obj/structure/spacevine/SV = new(location)
	growth_queue += SV
	vines += SV
	SV.master = src
	if(muts && muts.len)
		for(var/datum/spacevine_mutation/M in muts)
			M.add_mutation_to_vinepiece(SV)
	if(parent)
		SV.mutations |= parent.mutations
		var/parentcolor = parent.atom_colours[FIXED_COLOUR_PRIORITY]
		SV.add_atom_colour(parentcolor, FIXED_COLOUR_PRIORITY)
		if(prob(mutativeness))
			var/datum/spacevine_mutation/randmut = pick(vine_mutations_list - SV.mutations)
			randmut.add_mutation_to_vinepiece(SV)

	for(var/datum/spacevine_mutation/SM in SV.mutations)
		SM.on_birth(SV)
	location.Entered(SV)
	return SV

/datum/spacevine_controller/process()
	if(!LAZYLEN(vines))
		qdel(src) //space vines exterminated. Remove the controller
		return
	if(!growth_queue)
		qdel(src) //Sanity check
		return

	var/length = 0

	length = min( spread_cap , max( 1 , vines.len / spread_multiplier ) )
	var/i = 0
	var/list/obj/structure/spacevine/queue_end = list()

	for(var/obj/structure/spacevine/SV in growth_queue)
		if(QDELETED(SV))
			continue
		i++
		queue_end += SV
		growth_queue -= SV
		for(var/datum/spacevine_mutation/SM in SV.mutations)
			SM.process_mutation(SV)
		if(SV.energy < 2) //If tile isn't fully grown
			if(prob(20))
				SV.grow()
		else //If tile is fully grown
			SV.entangle_mob()

		SV.spread()
		if(i >= length)
			break

	growth_queue = growth_queue + queue_end

/obj/structure/spacevine/proc/grow()
	if(!energy)
		src.icon_state = pick("Med1", "Med2", "Med3")
		energy = 1
		set_opacity(1)
	else
		src.icon_state = pick("Hvy1", "Hvy2", "Hvy3")
		energy = 2

	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_grow(src)

/obj/structure/spacevine/proc/entangle_mob()
	if(!has_buckled_mobs() && prob(25))
		for(var/mob/living/V in src.loc)
			entangle(V)
			if(has_buckled_mobs())
				break //only capture one mob at a time


/obj/structure/spacevine/proc/entangle(mob/living/V)
	if(!V || isvineimmune(V))
		return
	for(var/datum/spacevine_mutation/SM in mutations)
		SM.on_buckle(src, V)
	if((V.stat != DEAD) && (V.buckled != src)) //not dead or captured
		to_chat(V, span_danger("The vines [pick("wind", "tangle", "tighten")] around you!"))
		buckle_mob(V, 1)

/obj/structure/spacevine/proc/spread()
	var/direction = pick(GLOB.cardinals)
	var/turf/stepturf = get_step(src,direction)
	if (!isspaceturf(stepturf) && stepturf.Enter(src))
		for(var/datum/spacevine_mutation/SM in mutations)
			SM.on_spread(src, stepturf)
			stepturf = get_step(src,direction) //in case turf changes, to make sure no runtimes happen
		if(!locate(/obj/structure/spacevine, stepturf))
			if(master)
				master.spawn_spacevine_piece(stepturf, src)

/obj/structure/spacevine/ex_act(severity, target)
	if(istype(target, type)) //if its agressive spread vine dont do anything
		return
	var/i
	for(var/datum/spacevine_mutation/SM in mutations)
		i += SM.on_explosion(severity, target, src)
	if(!i && prob(100/severity))
		qdel(src)

/obj/structure/spacevine/temperature_expose(null, temp, volume)
	var/override = 0
	for(var/datum/spacevine_mutation/SM in mutations)
		override += SM.process_temperature(src, temp, volume)
	if(!override)
		qdel(src)

/obj/structure/spacevine/CanAllowThrough(atom/movable/mover, border_dir)
	..()
	. = ..()
	if(isvineimmune(mover))
		return TRUE

/proc/isvineimmune(atom/A)
	if(isliving(A))
		var/mob/living/M = A
		if(("vines" in M.faction) || ("plants" in M.faction))
			return TRUE
	return FALSE
