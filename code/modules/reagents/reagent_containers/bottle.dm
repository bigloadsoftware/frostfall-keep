//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle

/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon_state = "bottle"
	item_state = "atoxinbottle"
	possible_transfer_amounts = list(5,10,15,25,30)
	volume = 30

/obj/item/reagent_containers/glass/bottle/Initialize()
	. = ..()
	if(!icon_state)
		icon_state = "bottle"
	update_icon()

/obj/item/reagent_containers/glass/bottle/on_reagent_change(changetype)
	update_icon()

/obj/item/reagent_containers/glass/bottle/update_overlays()
	. = ..()
	if(!cached_icon)
		cached_icon = icon_state
	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[cached_icon]-10", color = mix_color_from_reagents(reagents.reagent_list))

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "[cached_icon]-10"
			if(10 to 29)
				filling.icon_state = "[cached_icon]25"
			if(30 to 49)
				filling.icon_state = "[cached_icon]50"
			if(50 to 69)
				filling.icon_state = "[cached_icon]75"
			if(70 to INFINITY)
				filling.icon_state = "[cached_icon]100"

		. += filling

/obj/item/reagent_containers/glass/bottle/epinephrine
	name = "epinephrine bottle"
	desc = "A small bottle. Contains epinephrine - used to stabilize patients."
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30)

/obj/item/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/glass/bottle/toxin/waterskin
	name = "leather waterskin"
	desc = "A large pouch made from animal bits, meant to hold water or other liquids. It's best not to think which part of the animal this is."
	custom_materials = list(/datum/material/leather = 500)
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 60, 120)
	volume = 120
	icon = 'icons/obj/drinks.dmi'
	icon_state = "waterskin"
	slot_flags = INV_SLOTBIT_BELT

/obj/item/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)

/obj/item/reagent_containers/glass/bottle/spewium
	name = "spewium bottle"
	desc = "A small bottle of spewium."
	list_reagents = list(/datum/reagent/toxin/spewium = 30)

/obj/item/reagent_containers/glass/bottle/morphine
	name = "morphine bottle"
	desc = "A small bottle of morphine."
	icon = 'icons/obj/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/morphine = 30)

/obj/item/reagent_containers/glass/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/glass/bottle/charcoal
	name = "charcoal bottle"
	desc = "A small bottle of charcoal, which removes toxins and other chemicals from the bloodstream."
	list_reagents = list(/datum/reagent/medicine/charcoal = 30)

/obj/item/reagent_containers/glass/bottle/cryoxadone
	name = "cryoxadone bottle"
	desc = "A small bottle of cryoxadone, heals most types of damage when used in extremely cold enviornments."
	list_reagents = list(/datum/reagent/medicine/cryoxadone = 30)

/obj/item/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/glass/bottle/plasma
	name = "liquid plasma bottle"
	desc = "A small bottle of liquid plasma. Extremely toxic and reacts with micro-organisms inside blood."
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/glass/bottle/synaptizine
	name = "synaptizine bottle"
	desc = "A small bottle of synaptizine."
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/glass/bottle/formaldehyde
	name = "formaldehyde bottle"
	desc = "A small bottle of formaldehyde."
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle of ammonia."
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle of diethylamine."
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/glass/bottle/facid
	name = "Fluorosulfuric Acid Bottle"
	desc = "A small bottle. Contains a small amount of fluorosulfuric acid."
	list_reagents = list(/datum/reagent/toxin/acid/fluacid = 30)

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)

/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/glass/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

/obj/item/reagent_containers/glass/bottle/traitor
	name = "syndicate bottle"
	desc = "A small bottle. Contains a random nasty chemical."
	icon = 'icons/obj/chemical.dmi'
	var/extra_reagent = null

/obj/item/reagent_containers/glass/bottle/traitor/Initialize()
	. = ..()
	extra_reagent = pick(/datum/reagent/toxin/polonium, /datum/reagent/toxin/histamine, /datum/reagent/toxin/formaldehyde,
					/datum/reagent/toxin/venom, /datum/reagent/toxin/fentanyl, /datum/reagent/toxin/cyanide)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/glass/bottle/polonium
	name = "polonium bottle"
	desc = "A small bottle. Contains Polonium."
	list_reagents = list(/datum/reagent/toxin/polonium = 30)

/obj/item/reagent_containers/glass/bottle/magillitis
	name = "magillitis bottle"
	desc = "A small bottle. Contains a serum known only as 'magillitis'."
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/glass/bottle/venom
	name = "venom bottle"
	desc = "A small bottle. Contains Venom."
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/glass/bottle/fentanyl
	name = "fentanyl bottle"
	desc = "A small bottle. Contains Fentanyl."
	list_reagents = list(/datum/reagent/toxin/fentanyl = 30)

/obj/item/reagent_containers/glass/bottle/formaldehyde
	name = "formaldehyde bottle"
	desc = "A small bottle. Contains Formaldehyde."
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/glass/bottle/initropidril
	name = "initropidril bottle"
	desc = "A small bottle. Contains initropidril."
	list_reagents = list(/datum/reagent/toxin/initropidril = 30)

/obj/item/reagent_containers/glass/bottle/pancuronium
	name = "pancuronium bottle"
	desc = "A small bottle. Contains pancuronium."
	list_reagents = list(/datum/reagent/toxin/pancuronium = 30)

/obj/item/reagent_containers/glass/bottle/sodium_thiopental
	name = "sodium thiopental bottle"
	desc = "A small bottle. Contains sodium thiopental."
	list_reagents = list(/datum/reagent/toxin/sodium_thiopental = 30)

/obj/item/reagent_containers/glass/bottle/coniine
	name = "coniine bottle"
	desc = "A small bottle. Contains coniine."
	list_reagents = list(/datum/reagent/toxin/coniine = 30)

/obj/item/reagent_containers/glass/bottle/curare
	name = "curare bottle"
	desc = "A small bottle. Contains curare."
	list_reagents = list(/datum/reagent/toxin/curare = 30)

/obj/item/reagent_containers/glass/bottle/amanitin
	name = "amanitin bottle"
	desc = "A small bottle. Contains amanitin."
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)

/obj/item/reagent_containers/glass/bottle/histamine
	name = "histamine bottle"
	desc = "A small bottle. Contains Histamine."
	list_reagents = list(/datum/reagent/toxin/histamine = 30)

/obj/item/reagent_containers/glass/bottle/diphenhydramine
	name = "antihistamine bottle"
	desc = "A small bottle of diphenhydramine."
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 30)

/obj/item/reagent_containers/glass/bottle/potass_iodide
	name = "anti-radiation bottle"
	desc = "A small bottle of potassium iodide."
	list_reagents = list(/datum/reagent/medicine/potass_iodide = 30)

/obj/item/reagent_containers/glass/bottle/salglu_solution
	name = "saline-glucose solution bottle"
	desc = "A small bottle of saline-glucose solution."
	icon_state = "bottle1"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 30)

/obj/item/reagent_containers/glass/bottle/atropine
	name = "atropine bottle"
	desc = "A small bottle of atropine."
	list_reagents = list(/datum/reagent/medicine/atropine = 30)

/obj/item/reagent_containers/glass/bottle/zeolites
	name = "Zeolites bottle"
	desc = "A small bottle of lab made Zeolite, which removes radiation from people quickly as well as contamination on items."
	list_reagents = list(/datum/reagent/fermi/zeolites = 30)

// Viro bottles

/obj/item/reagent_containers/glass/bottle/romerol
	name = "romerol bottle"
	desc = "A small bottle of Romerol. The REAL zombie powder."
	list_reagents = list(/datum/reagent/romerol = 30)

/obj/item/reagent_containers/glass/bottle/random_virus
	name = "Experimental disease culture bottle"
	desc = "A small bottle. Contains an untested viral culture in synthblood medium."
	spawned_disease = /datum/disease/advance/random

/obj/item/reagent_containers/glass/bottle/pierrot_throat
	name = "Pierrot's Throat culture bottle"
	desc = "A small bottle. Contains H0NI<42 virion culture in synthblood medium."
	spawned_disease = /datum/disease/pierrot_throat

/obj/item/reagent_containers/glass/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "A small bottle. Contains XY-rhinovirus culture in synthblood medium."
	spawned_disease = /datum/disease/advance/cold

/obj/item/reagent_containers/glass/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "A small bottle. Contains H13N1 flu virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/flu

/obj/item/reagent_containers/glass/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "A small bottle. Contains a retrovirus culture in a synthblood medium."
	spawned_disease = /datum/disease/dna_retrovirus

/obj/item/reagent_containers/glass/bottle/gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS+ culture in synthblood medium."//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs

/obj/item/reagent_containers/glass/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS- culture in synthblood medium."//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs

/obj/item/reagent_containers/glass/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "A small bottle. Contains Cryptococcus Cosmosis culture in synthblood medium."
	icon_state = "bottle3"
	spawned_disease = /datum/disease/brainrot

/obj/item/reagent_containers/glass/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "A small bottle. Contains a small dosage of Fukkos Miracos."
	spawned_disease = /datum/disease/magnitis

/obj/item/reagent_containers/glass/bottle/wizarditis
	name = "Wizarditis culture bottle"
	desc = "A small bottle. Contains a sample of Rincewindus Vulgaris."
	spawned_disease = /datum/disease/wizarditis

/obj/item/reagent_containers/glass/bottle/anxiety
	name = "Severe Anxiety culture bottle"
	desc = "A small bottle. Contains a sample of Lepidopticides."
	spawned_disease = /datum/disease/anxiety

/obj/item/reagent_containers/glass/bottle/beesease
	name = "Beesease culture bottle"
	desc = "A small bottle. Contains a sample of invasive Apidae."
	spawned_disease = /datum/disease/beesease

/obj/item/reagent_containers/glass/bottle/fluspanish
	name = "Spanish flu culture bottle"
	desc = "A small bottle. Contains a sample of Inquisitius."
	spawned_disease = /datum/disease/fluspanish

/obj/item/reagent_containers/glass/bottle/tuberculosis
	name = "Fungal Tuberculosis culture bottle"
	desc = "A small bottle. Contains a sample of Fungal Tubercle bacillus."
	spawned_disease = /datum/disease/tuberculosis

/obj/item/reagent_containers/glass/bottle/tuberculosiscure
	name = "BVAK bottle"
	desc = "A small bottle containing Bio Virus Antidote Kit."
	list_reagents = list(/datum/reagent/medicine/atropine = 5, /datum/reagent/medicine/epinephrine = 5, /datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/spaceacillin = 10)

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/glass/bottle/hydrogen
	name = "hydrogen bottle"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/glass/bottle/lithium
	name = "lithium bottle"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/glass/bottle/carbon
	name = "carbon bottle"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/glass/bottle/nitrogen
	name = "nitrogen bottle"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/glass/bottle/oxygen
	name = "oxygen bottle"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/glass/bottle/fluorine
	name = "fluorine bottle"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/glass/bottle/sodium
	name = "sodium bottle"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/glass/bottle/aluminium
	name = "aluminium bottle"
	list_reagents = list(/datum/reagent/aluminium = 30)

/obj/item/reagent_containers/glass/bottle/silicon
	name = "silicon bottle"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/glass/bottle/phosphorus
	name = "phosphorus bottle"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/glass/bottle/sulfur
	name = "sulfur bottle"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/glass/bottle/chlorine
	name = "chlorine bottle"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/glass/bottle/potassium
	name = "potassium bottle"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/glass/bottle/iron
	name = "iron bottle"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/glass/bottle/copper
	name = "copper bottle"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/glass/bottle/mercury
	name = "mercury bottle"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/glass/bottle/radium
	name = "radium bottle"
	list_reagents = list(/datum/reagent/radium = 30)

/obj/item/reagent_containers/glass/bottle/water
	name = "water bottle"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/glass/bottle/ethanol
	name = "ethanol bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/glass/bottle/sugar
	name = "sugar bottle"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/glass/bottle/sacid
	name = "sulphuric acid bottle"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/glass/bottle/welding_fuel
	name = "welding fuel bottle"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/glass/bottle/welding_fuel/big
	name = "XL welding fuel bottle"
	volume = 45
	list_reagents = list(/datum/reagent/fuel = 45)

/obj/item/reagent_containers/glass/bottle/silver
	name = "silver bottle"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/glass/bottle/iodine
	name = "iodine bottle"
	list_reagents = list(/datum/reagent/iodine = 30)

/obj/item/reagent_containers/glass/bottle/bromine
	name = "bromine bottle"
	list_reagents = list(/datum/reagent/bromine = 30)

//Ichors
/obj/item/reagent_containers/glass/bottle/ichor
	possible_transfer_amounts = list(1)
	volume = 1

/obj/item/reagent_containers/glass/bottle/ichor/red
	name = "healing potion"
	list_reagents = list(/datum/reagent/red_ambrosia = 1)

/obj/item/reagent_containers/glass/bottle/ichor/blue
	name = "blue potion"
	list_reagents = list(/datum/reagent/blue_ambrosia = 1)

/obj/item/reagent_containers/glass/bottle/ichor/green
	name = "green potion"
	list_reagents = list(/datum/reagent/green_ambrosia = 1)

/obj/item/reagent_containers/glass/bottle/blackpowder
	name = "blackpowder bottle"
	desc = "A large bottle containing black powder."
	volume = 60
	list_reagents = list(/datum/reagent/blackpowder = 60)

// FEV
/*
/obj/item/reagent_containers/glass/bottle/FEV_solution
	name = "FEV bottle"
	desc = "A small vial of the Forced Evolutionary Virus. You think that consuming this would be a bad idea."
	list_reagents = list(/datum/reagent/toxin/FEV_solution/one = 30)

/obj/item/reagent_containers/glass/bottle/FEV_solution/two
	name = "FEV-II bottle"
	list_reagents = list(/datum/reagent/toxin/FEV_solution/two = 30)

/obj/item/reagent_containers/glass/bottle/FEV_solution/curling
	name = "Curling-13 bottle"
	list_reagents = list(/datum/reagent/toxin/FEV_solution/curling = 30)
*/
//Curling 13 vaccine
/obj/item/reagent_containers/glass/bottle/curling_vaccine
	name = "Curling 13 vaccine bottle"
	desc = "A vial with all reagents needed to cure Curling-13 virus. intended for use by the Enclave personnel to prevent infection."
	list_reagents = list(
					/datum/reagent/medicine/mutadone = 10,
					/datum/reagent/medicine/haloperidol = 10,
					/datum/reagent/medicine/spaceacillin = 10,
					)

/obj/item/reagent_containers/glass/bottle/gaia
	name = "gaia bottle"
	desc = "A large bottle containing gaia."
	volume = 60
	list_reagents = list(/datum/reagent/medicine/gaia = 60)

/obj/item/reagent_containers/glass/bottle/omnizine
	name = "omnizine bottle"
	desc = "A large bottle containing omnizine."
	volume = 60
	list_reagents = list(/datum/reagent/medicine/omnizine = 60)

/obj/item/reagent_containers/glass/bottle/sanguirite
	name = "sanguirite bottle"
	desc = "A large bottle containing sanguirite."
	volume = 30
	list_reagents = list(/datum/reagent/medicine/coagulant = 30)

/obj/item/reagent_containers/glass/bottle/primitive
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "bottle_primitive"
	possible_transfer_amounts = list(5,10,15,20,30,60)
	volume = 60

/obj/item/reagent_containers/glass/bottle/primitive/update_overlays()
	. = ..()
	if(!cached_icon)
		cached_icon = icon_state
	if(reagents.total_volume)
		return

//f13 - Coyote
/obj/item/reagent_containers/glass/bottle/nicotine
	name = "nicotine bottle"
	list_reagents = list(/datum/reagent/drug/nicotine = 30)

/obj/item/reagent_containers/glass/bottle/methamphetamine
	name = "methamphetamine bottle"
	list_reagents = list(/datum/reagent/drug/methamphetamine = 30)

/obj/item/reagent_containers/glass/bottle/crank
	name = "crank bottle"
	list_reagents = list(/datum/reagent/drug/crank = 30)

/obj/item/reagent_containers/glass/bottle/random
	name = "randomized bottle"
	desc = "A long forgotten prescription. who knows what it contains."

/obj/item/reagent_containers/glass/bottle/random/Initialize()
	list_reagents = list(get_random_reagent_id() = rand(5,15))
	var/bottle_name = pick("candy", "fun", "discarded", "forgotten", "old", "ancient", "random", "unknown", "strange", "abandoned", "hobo", "trash", "forsaken", "alluring", "peculiar", "anomalous", "unfamiliar", "odd", "funny", "tasty", "neglected", "mysterious", "strange")
	name = "[bottle_name] bottle"
	. = ..()

/obj/item/reagent_containers/glass/bottle/synthjuice
	name = "synthetic repair paste"
	desc = "A small bottle full of synthetic repair gel. Not for organic consumption."
	volume = 120
	list_reagents = list(/datum/reagent/fuel/robo_repair_gel = 120)
