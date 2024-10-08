//Subtype of human
/datum/species/human/halfbreed
	name = "Half-Breed"
	id = "halfbreed"
	limbs_id = "human"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,MUTCOLORS_PARTSONLY,WINGCOLOR,HAS_FLESH,HAS_BONE)
	mutant_bodyparts = list("mam_tail" = "Husky",
							"mam_ears" = "Husky",
							"deco_wings" = "None",
							"mam_body_markings" = "Husky", 
							"taur" = "None",
							"horns" = "None",
							"legs" = "Plantigrade",
							"insect_fluff" = "None",
							"meat_type" = "Mammalian")

	use_skintones = USE_SKINTONES_GRAYSCALE_CUSTOM
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | LONGPORK
	liked_food = JUNKFOOD | FRIED

	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	species_type = "furry"


/proc/mass_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishumanbasic(M))
			purrbation_apply(M)
		CHECK_TICK

/proc/mass_remove_purrbation()
	for(var/M in GLOB.mob_list)
		if(ishumanbasic(M))
			purrbation_remove(M)
		CHECK_TICK

/proc/purrbation_toggle(mob/living/carbon/human/H, silent = FALSE)
	if(!ishumanbasic(H))
		return
	if(!iscatperson(H))
		purrbation_apply(H, silent)
		. = TRUE
	else
		purrbation_remove(H, silent)
		. = FALSE

/proc/purrbation_apply(mob/living/carbon/human/H, silent = FALSE)
	if(!ishuman(H) || iscatperson(H))
		return
	H.set_species(/datum/species/human/halfbreed)

	if(!silent)
		to_chat(H, "Something is nya~t right.")
		playsound(get_turf(H), 'sound/effects/meow1.ogg', 50, 1, -1)

/proc/purrbation_remove(mob/living/carbon/human/H, silent = FALSE)
	if(!ishuman(H) || !iscatperson(H))
		return

	H.set_species(/datum/species/human)

	if(!silent)
		to_chat(H, "You are no longer a cat.")
