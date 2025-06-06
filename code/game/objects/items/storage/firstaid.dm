
/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 *		Dice Pack (in a pill bottle)
 */

/*
 * First Aid Kits
 */
/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon_state = "firstaid"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	var/list/possible_icons = list("firstaid","firstaid2","firstaid3","firstaid4")

/obj/item/storage/firstaid/Initialize(mapload)
	. = ..()
	if(LAZYLEN(possible_icons))
		icon_state = pick(possible_icons)

/obj/item/storage/firstaid/regular
	icon_state = "firstaid"
	desc = "A first aid kit with the ability to heal common types of injuries."

/obj/item/storage/firstaid/regular/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)

/obj/item/storage/firstaid/emergency
	icon_state = "medbriefcase"
	name = "emergency first-aid kit"
	desc = "A very simple first aid kit meant to secure and stabilize serious wounds for later treatment."

/obj/item/storage/firstaid/emergency/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/healthanalyzer/wound = 1,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/stack/medical/suture/emergency = 3,
		/obj/item/stack/medical/ointment = 1,
		/obj/item/reagent_containers/hypospray/medipen/ekit = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/firstaid/ancient
	icon_state = "firstaid"
	desc = "A first aid kit with the ability to heal common types of injuries."

/obj/item/storage/firstaid/ancient/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/reagent_containers/syringe/charcoal(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak/epipak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak/glucose(src)

/obj/item/storage/firstaid/fire
	name = "burn treatment kit"
	desc = "A specialized medical kit for when the toxins lab <i>-spontaneously-</i> burns down."
	icon_state = "burn"
	item_state = "firstaid-ointment"
	possible_icons = list("burn","burn2","burn3","burn4")

/obj/item/storage/firstaid/fire/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/patch/silver_sulf(src)
	new /obj/item/reagent_containers/pill/oxandrolone(src)
	new /obj/item/reagent_containers/pill/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/toxin
	name = "toxin treatment kit"
	desc = "Used to treat toxic blood content and radiation poisoning."
	icon_state = "toxin"
	item_state = "firstaid-toxin"
	possible_icons = list("toxin","toxin2","toxin3","toxin4")

/obj/item/storage/firstaid/toxin/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/syringe/charcoal(src)
	for(var/i in 1 to 2)
		new /obj/item/storage/pill_bottle/charcoal(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/radbgone
	name = "radiation treatment kit"
	desc = "Used to treat minor toxic blood content and major radiation poisoning."
	icon_state = "rad"
	item_state = "firstaid-toxin"
	possible_icons = list("rad","rad2","rad3")

/obj/item/storage/firstaid/radbgone/PopulateContents()
	if(empty)
		return
	if(prob(50))
		new /obj/item/reagent_containers/pill/mutarad(src)
	if(prob(80))
		new /obj/item/reagent_containers/pill/antirad_plus(src)
	new /obj/item/reagent_containers/syringe/charcoal(src)
	new /obj/item/storage/pill_bottle/charcoal(src)
	new /obj/item/reagent_containers/pill/mutadone(src)
	new /obj/item/reagent_containers/pill/antirad(src)
	new /obj/item/reagent_containers/food/drinks/bottle/vodka(src)
	new /obj/item/healthanalyzer(src)


/obj/item/storage/firstaid/o2
	name = "oxygen deprivation treatment kit"
	desc = "A box full of oxygen goodies."
	icon_state = "oxy"
	item_state = "firstaid-o2"
	possible_icons = list("oxy", "oxy2", "oxy3", "oxy4")

/obj/item/storage/firstaid/o2/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/brute
	name = "brute trauma treatment kit"
	desc = "A first aid kit for when you get toolboxed."
	icon_state = "brute"
	item_state = "firstaid-brute"
	possible_icons = list("brute", "brute2", "brute3", "brute4")

/obj/item/storage/firstaid/brute/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/patch/styptic(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/tactical
	name = "combat medical kit"
	desc = "I hope you've got insurance."
	icon_state = "tactical"
	possible_icons = null

/obj/item/storage/firstaid/tactical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 16
	STR.max_items = 8

/obj/item/storage/firstaid/tactical/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze/adv(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat/omnizine(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/reagent_containers/pill/blueambrosia(src)

/obj/item/storage/firstaid/tactical/nukeop
	name = "improved combat medical kit"

/obj/item/storage/firstaid/tactical/nukeop/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/reagent_containers/medspray/styptic(src)
	new /obj/item/reagent_containers/medspray/silver_sulf(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/reagent_containers/syringe/lethal/choral(src) // what the fuck does anyone use this piece of shit for
//	new /obj/item/clothing/glasses/hud/health/night/syndicate(src)

/obj/item/storage/firstaid/debug_bleedtest
	name = span_phobia("Debug Testkit For Testing Bleedstuff quickly (illegal)")
	icon_state = "firstaid"
	desc = span_love("I got tired of spawning in the same stuff, so I made a kit.")
	component_type = /datum/component/storage/concrete/box/huge

/obj/item/storage/firstaid/debug_bleedtest/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/gauze/adv(src)
	new /obj/item/stack/medical/gauze/improvised(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/suture/emergency(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/melee/onehanded/knife/survival(src)
	new /obj/item/melee/onehanded/machete/scrapsabre(src)
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/gun/ballistic/automatic/rangemaster(src)
	new /obj/item/gun/ballistic/automatic/r84(src)
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/gun/ballistic/shotgun/trench(src)
	new /obj/item/gun/ballistic/shotgun/trench(src)
	new /obj/item/gun/ballistic/shotgun/trench(src)

/*
 * Pill Bottles
 */

/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/pill_bottle/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT
	STR.max_volume = STORAGE_VOLUME_PILL_BOTTLE
	STR.allow_quick_gather = TRUE
	STR.click_gather = TRUE
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/pill, /obj/item/dice))
	STR.cant_hold = typecacheof(list(
		/obj/item/reagent_containers/pill/patch/jet,
		/obj/item/reagent_containers/pill/patch/turbo,
		/obj/item/reagent_containers/pill/healingpowder,
		/obj/item/reagent_containers/pill/bitterdrink,
		/obj/item/reagent_containers/pill/patch/healpoultice))

/obj/item/storage/pill_bottle/AltClick(mob/living/carbon/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("Your hands are full!"))
		return
	var/obj/item/reagent_containers/pill/P = locate() in contents
	if(P)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, P, user, FALSE)
		if(!user.put_in_hands(P))
			P.forceMove(user.drop_location())	// make sure it's not stuck in the user if the put in hands somehow fails
			to_chat(user, span_warning("[P] drops to the floor!"))
		else
			to_chat(user, span_notice("You take \a [P] out of [src]."))
	else
		to_chat(user, span_notice("There are no pills left in the bottle."))
	return TRUE


/obj/item/storage/pill_bottle/charcoal
	name = "bottle of charcoal pills"
	desc = "Contains pills used to counter toxins."

/obj/item/storage/pill_bottle/charcoal/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/charcoal(src)

/obj/item/storage/pill_bottle/antirad
	name = "bottle of charcoal pills"
	desc = "Contains pills used to counter radiation poisoning."

/obj/item/storage/pill_bottle/anitrad/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/antirad(src)

/obj/item/storage/pill_bottle/epinephrine
	name = "bottle of epinephrine pills"
	desc = "Contains pills used to stabilize patients."

/obj/item/storage/pill_bottle/epinephrine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/epinephrine(src)

/obj/item/storage/pill_bottle/mutadone
	name = "bottle of mutadone pills"
	desc = "Contains pills used to treat genetic abnormalities."

/obj/item/storage/pill_bottle/mutadone/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mutadone(src)

/obj/item/storage/pill_bottle/mannitol
	name = "bottle of mannitol pills"
	desc = "Contains pills used to treat brain damage."

/obj/item/storage/pill_bottle/mannitol/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mannitol(src)

/obj/item/storage/pill_bottle/stimulant
	name = "bottle of stimulant pills"
	desc = "Guaranteed to give you that extra burst of energy during a long shift!"

/obj/item/storage/pill_bottle/stimulant/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/stimulant(src)

/obj/item/storage/pill_bottle/mining
	name = "bottle of patches"
	desc = "Contains patches used to treat brute and burn damage."

/obj/item/storage/pill_bottle/mining/PopulateContents()
	new /obj/item/reagent_containers/pill/patch/silver_sulf(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/pill/patch/styptic(src)

/obj/item/storage/pill_bottle/zoom
	name = "suspicious pill bottle"
	desc = "The label is pretty old and almost unreadable, you recognize some chemical compounds."

/obj/item/storage/pill_bottle/zoom/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/zoom(src)

/obj/item/storage/pill_bottle/happy
	name = "suspicious pill bottle"
	desc = "There is a smiley on the top."

/obj/item/storage/pill_bottle/happy/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/happy(src)

/obj/item/storage/pill_bottle/lsd
	name = "suspicious pill bottle"
	desc = "There is a badly drawn thing with the shape of a mushroom."

/obj/item/storage/pill_bottle/lsd/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/lsd(src)

/obj/item/storage/pill_bottle/aranesp
	name = "suspicious pill bottle"
	desc = "The label says 'gotta go fast'."

/obj/item/storage/pill_bottle/aranesp/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/aranesp(src)
/*
/obj/item/storage/pill_bottle/psicodine
	name = "bottle of psicodine pills"
	desc = "Contains pills used to treat mental distress and traumas."

/obj/item/storage/pill_bottle/psicodine/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/psicodine(src)
*/
/obj/item/storage/pill_bottle/happiness
	name = "happiness pill bottle"
	desc = "The label is long gone, in its place an 'H' written with a marker."

/obj/item/storage/pill_bottle/happiness/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/happiness(src)

/obj/item/storage/pill_bottle/antirad_plus
	name = "anti radiation deluxe pill bottle"
	desc = "The label says 'Med-Co branded pills'."

/obj/item/storage/pill_bottle/antirad_plus/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/antirad_plus(src)

/obj/item/storage/pill_bottle/mutarad
	name = "radiation treatment deluxe pill bottle"
	desc = "The label says 'Med-Co branded pills' and below that 'Contains Mutadone in each pill!`."

/obj/item/storage/pill_bottle/mutarad/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/mutarad(src)

/obj/item/storage/pill_bottle/neurine
	name = "bottle of neurine pills"
	desc = "Contains pills to treat non-severe mental traumas."

/obj/item/storage/pill_bottle/neurine/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/neurine(src)

/obj/item/storage/pill_bottle/breast_enlarger
	name = "bottle of female enhancement pills"
	desc = "Members of the Itty Bitty Titty Committee rejoice! 'Missus' has you covered! Grow large, 100% natural breasts with just one \
		tablet! Works on any species, and can even grow breasts on creatures who don't normally have them! \
		Never let nature dictate your curves again! Use the coupon code on the back for a free sizing for a bra!"
/obj/item/storage/pill_bottle/breast_enlarger/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/breast_enlarger(src)

/obj/item/storage/pill_bottle/butt_enlarger
	name = "bottle of callipygian capsules"
	desc = "Ever wish you had a bit more cushion for the pushin'? Not any more with Doctor D-Zels' patented callipygian capsules! \
		Lab tested on some of the happiest wasters around, these are guarenteed to give you a rear worth talking about. \
		Works on any organic lifeform. D-Zel is not responsible for any loss of mobility, pregnancy, exhaustion, dehydration, or bruising caused by use of this product."
/obj/item/storage/pill_bottle/butt_enlarger/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/butt_enlarger(src)

/obj/item/storage/pill_bottle/penis_enlarger
	name = "bottle of male enhancement pills"
	desc = "Ever wish your iron was a Big Iron? Get made fun of for being out-gunned in the sack? Not anymore with Doctor D-Zels' big blue pills! \
		Lab tested on some of the most packing men (and women) in Texarkana, and guarenteed to give your friends a shock. \
		Works on any organic lifeform, even those lacking male anatomy. D-Zel is not responsible for pregnancy, newfound fetishes, exhaustion, dehydration, or the formation of harems."
/obj/item/storage/pill_bottle/penis_enlarger/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/penis_enhancement(src)

/obj/item/storage/pill_bottle/belly_enlarger
	name = "bottle of weight gain pills"
	desc = "Feeling a bit underweight? Famines got you down? Or maybe you just want that healthy wobble people adore in the wasteland? \
		---*-/ has got your back! With targeted weight enhancement you'll be bulked up in no time!"
/obj/item/storage/pill_bottle/belly_enlarger/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/belly_enlarger(src)

/obj/item/storage/pill_bottle/random
	name = "bottle of randomized pills"
	desc = "Contains a collection of old, potentially dangerous, potentially tasty pills."

/obj/item/storage/pill_bottle/random/Initialize()
	icon_state = "pill_canister[rand(1,3)]"
	var/bottle_name = pick("candy", "fun", "discarded", "forgotten", "old", "ancient", "random", "unknown", "strange", "abandoned", "hobo", "trash", "forsaken", "alluring", "peculiar", "anomalous", "unfamiliar", "odd", "funny", "tasty", "neglected", "mysterious", "strange")
	name = "bottle of [bottle_name] pills"
	. = ..()

/obj/item/storage/pill_bottle/random/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/random(src)

/////////////
//Organ Box//
/////////////

/obj/item/storage/belt/organbox
	name = "Organ Storage"
	desc = "A compact box that helps hold massive amounts of implants, organs, and some tools. Has a belt clip for easy carrying"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/mysterybox.dmi'
	icon_state = "organbox_open"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 1
	throw_range = 1

/obj/item/storage/belt/organbox/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 20
	STR.can_hold = typecacheof(list(
	/obj/item/storage/pill_bottle,
	/obj/item/reagent_containers/hypospray,
	/obj/item/pinpointer/crew,
	/obj/item/tele_iv,
	/obj/item/sequence_scanner,
	/obj/item/sensor_device,
	/obj/item/bodybag,
	/obj/item/surgicaldrill/advanced,
	/obj/item/healthanalyzer,
	/obj/item/reagent_containers/syringe,
	/obj/item/clothing/glasses/hud/health,
	/obj/item/hemostat,
	/obj/item/scalpel,
	/obj/item/retractor,
	/obj/item/cautery,
	/obj/item/surgical_drapes,
	/obj/item/bonesetter,
	/obj/item/autosurgeon,
	/obj/item/organ,
	/obj/item/implant,
	/obj/item/implantpad,
	/obj/item/implantcase,
	/obj/item/implanter,
	/obj/item/circuitboard/computer/operating,
	/obj/item/circuitboard/computer/crew,
	/obj/item/stack/sheet/glass,
	/obj/item/stack/sheet/mineral/silver,
	/obj/item/organ_storage,
	/obj/item/reagent_containers/chem_pack
	))

//hijacking the minature first aids for hypospray boxes. <3
/obj/item/storage/hypospraykit
	name = "hypospray kit"
	desc = "It's a kit containing a hypospray and specific treatment chemical-filled vials."
	icon_state = "firstaid-mini"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	item_state = "firstaid"
	custom_price = PRICE_REALLY_EXPENSIVE
	custom_premium_price = PRICE_REALLY_EXPENSIVE

/obj/item/storage/hypospraykit/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 12
	STR.can_hold = typecacheof(list(
	/obj/item/hypospray/mkii,
	/obj/item/reagent_containers/glass/bottle/vial))

/obj/item/storage/hypospraykit/regular
	icon_state = "firstaid-mini"
	desc = "A hypospray kit with general use vials."

/obj/item/storage/hypospraykit/regular/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/tricord(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/tricord(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/tricord(src)

/obj/item/storage/hypospraykit/fire
	name = "burn treatment hypospray kit"
	desc = "A specialized hypospray kit for burn treatments. Apply with sass."
	icon_state = "burn-mini"
	item_state = "firstaid-ointment"

/obj/item/storage/hypospraykit/fire/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/burn(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/kelotane(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/kelotane(src)

/obj/item/storage/hypospraykit/toxin
	name = "toxin treatment hypospray kit"
	icon_state = "toxin-mini"
	item_state = "firstaid-toxin"

/obj/item/storage/hypospraykit/toxin/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/toxin(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/antitoxin(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/antitoxin(src)

/obj/item/storage/hypospraykit/o2
	name = "oxygen deprivation hypospray kit"
	icon_state = "oxy-mini"
	item_state = "firstaid-o2"

/obj/item/storage/hypospraykit/o2/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/oxygen(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/dexalin(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/dexalin(src)

/obj/item/storage/hypospraykit/brute
	name = "brute trauma hypospray kit"
	icon_state = "brute-mini"
	item_state = "firstaid-brute"

/obj/item/storage/hypospraykit/brute/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/brute(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/bicaridine(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small/bicaridine(src)

/obj/item/storage/hypospraykit/tactical
	name = "combat hypospray kit"
	desc = "A hypospray kit best suited for combat situations."
	icon_state = "tactical-mini"

/obj/item/storage/hypospraykit/tactical/PopulateContents()
	if(empty)
		return
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/hypospray/mkii/CMO/combat(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/combat(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/combat(src)

/obj/item/storage/hypospraykit/cmo
	name = "deluxe hypospray kit"
	desc = "A kit containing a Deluxe hypospray and Vials."
	icon_state = "tactical-mini"

/obj/item/storage/hypospraykit/cmo/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/CMO(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/tricord(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/charcoal(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/salglu(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/dexalin(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large/synthflesh(src)

/obj/item/storage/box/vials
	name = "box of hypovials"

/obj/item/storage/box/vials/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/glass/bottle/vial/small( src )

/////////////
// FALLOUT //
/////////////

/obj/item/storage/pill_bottle/chem_tin/
	name = "chem tin"
	desc = "A branded tin made to hold ingestable chems."

/obj/item/storage/pill_bottle/chem_tin/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.allow_quick_gather = TRUE
	STR.click_gather = TRUE
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/pill, /obj/item/reagent_containers/syringe, /obj/item/dice))

// ---------------------------------------------
// MENTAT TIN

/obj/item/storage/pill_bottle/chem_tin/mentats
	name = "Mentats tin"
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_canister_mentats"
	desc = "Contains pills used to increase intelligence and perception."

/obj/item/storage/pill_bottle/chem_tin/mentats/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/mentat(src)

/obj/item/storage/pill_bottle/chem_tin/mentats/grape
	name = "Grape Mentats tin"
	desc = "Contains pills used to increase intelligence and perception. Now in three flavors!"

/obj/item/storage/pill_bottle/chem_tin/mentats/grape/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/mentat/grape(src)

/obj/item/storage/pill_bottle/chem_tin/mentats/orange
	name = "Orange Mentats tin"
	desc = "Contains pills used to increase intelligence and perception. Now in three flavors!"

/obj/item/storage/pill_bottle/chem_tin/mentats/orange/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/mentat/orange(src)

/obj/item/storage/pill_bottle/chem_tin/mentats/berry
	name = "Berry Mentats tin"
	desc = "Contains pills used to increase intelligence and perception. Now in three flavors!"

/obj/item/storage/pill_bottle/chem_tin/mentats/berry/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/mentat/berry(src)

// ---------------------------------------------
// FIXER TIN

/obj/item/storage/pill_bottle/chem_tin/fixer
	name = "Fixer tin"
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_canister_fixer"
	desc = "Contains pills used to treat addiction and overdose on other chems."

/obj/item/storage/pill_bottle/chem_tin/fixer/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/fixer(src)

// ---------------------------------------------
// RAD-X PILL BOTTLE

/obj/item/storage/pill_bottle/chem_tin/radx
	name = "Rad-X bottle"
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_canister_radx"
	desc = "Contains pills that prevent radiation buildup, totally shielding the user at high doses. Does not treat radiation sickness, best taken before exposure."

/obj/item/storage/pill_bottle/chem_tin/radx/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/radx(src)

// ---------------------------------------------
// BUFFOUT PILL BOTTLE

/obj/item/storage/pill_bottle/chem_tin/buffout
	name = "Buffout bottle"
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_canister_buffout"
	desc = "Contains pills used to increase muscle mass."

/obj/item/storage/pill_bottle/chem_tin/buffout/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/buffout(src)

