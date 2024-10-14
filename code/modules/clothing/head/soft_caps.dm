/obj/item/clothing/head/soft
	name = "cargo cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "cargosoft"
	item_state = "helmet"
	var/soft_type = "cargo"

	dog_fashion = /datum/dog_fashion/head/cargo_tech

	var/flipped = 0

/obj/item/clothing/head/soft/dropped(mob/user)
	icon_state = "[soft_type]soft"
	flipped = FALSE
	return ..()

/obj/item/clothing/head/soft/verb/flipcap()
	set category = "Object"
	set name = "Flip cap"

	flip(usr)


/obj/item/clothing/head/soft/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	flip(user)
	return TRUE


/obj/item/clothing/head/soft/proc/flip(mob/user)
	if(!user.incapacitated(allow_crit = TRUE))
		src.flipped = !src.flipped
		if(src.flipped)
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, span_notice("You flip the hat backwards."))
		else
			icon_state = "[soft_type]soft"
			to_chat(user, span_notice("You flip the hat back in normal position."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/soft/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the cap to flip it [flipped ? "forwards" : "backwards"].")

/obj/item/clothing/head/soft/red
	name = "red cap"
	desc = "It's a baseball hat in a tasteless red colour."
	icon_state = "redsoft"
	soft_type = "red"
	dog_fashion = null

/obj/item/clothing/head/soft/blue
	name = "blue cap"
	desc = "It's a baseball hat in a tasteless blue colour."
	icon_state = "bluesoft"
	soft_type = "blue"
	dog_fashion = null

/obj/item/clothing/head/soft/green
	name = "green cap"
	desc = "It's a baseball hat in a tasteless green colour."
	icon_state = "greensoft"
	soft_type = "green"
	dog_fashion = null

/obj/item/clothing/head/soft/yellow
	name = "yellow cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "yellowsoft"
	soft_type = "yellow"
	dog_fashion = null

/obj/item/clothing/head/soft/grey
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	soft_type = "grey"
	dog_fashion = null

/obj/item/clothing/head/soft/orange
	name = "orange cap"
	desc = "It's a baseball hat in a tasteless orange colour."
	icon_state = "orangesoft"
	soft_type = "orange"
	dog_fashion = null

/obj/item/clothing/head/soft/mime
	name = "white cap"
	desc = "It's a baseball hat in a tasteless white colour."
	icon_state = "mimesoft"
	soft_type = "mime"
	dog_fashion = null

/obj/item/clothing/head/soft/purple
	name = "purple cap"
	desc = "It's a baseball hat in a tasteless purple colour."
	icon_state = "purplesoft"
	soft_type = "purple"
	dog_fashion = null

/obj/item/clothing/head/soft/black
	name = "black cap"
	desc = "It's a baseball hat in a tasteless black colour."
	icon_state = "blacksoft"
	soft_type = "black"
	dog_fashion = null

/obj/item/clothing/head/soft/rainbow
	name = "rainbow cap"
	desc = "It's a baseball hat in a bright rainbow of colors."
	icon_state = "rainbowsoft"
	soft_type = "rainbow"
	dog_fashion = null

/obj/item/clothing/head/soft/sec
	name = "security cap"
	desc = "It's a robust baseball hat in tasteful red colour."
	icon_state = "secsoft"
	soft_type = "sec"
	strip_delay = 60
	dog_fashion = null

/obj/item/clothing/head/soft/emt
	name = "EMT cap"
	desc = "It's a baseball hat with a dark turquoise color and a reflective cross on the top."
	icon_state = "emtsoft"
	soft_type = "emt"
	dog_fashion = null

/obj/item/clothing/head/soft/baseball
	name = "baseball cap"
	desc = "It's a robust baseball hat, this one belongs to syndicate major league team."
	icon_state = "baseballsoft"
	soft_type = "baseball"
	item_state = "baseballsoft"
	flags_inv = HIDEEYES|HIDEFACE
	strip_delay = 90 //You dont take a Major Leage cap
	dog_fashion = null

// Medieval stuff

/obj/item/clothing/head/chaperon
	name = "brown chaperon"
	desc = "A fancy cloth hat that can be worn either folded up atop ones head (chaperon) or as a hood (liripipe). This one's brown."
	icon_state = "chaperonbrownsoft"
	item_state = "helmet"
	var/soft_type = "chaperonbrown"

	dog_fashion = null ///datum/dog_fashion/head/cargo_tech

	var/flipped = 0

/obj/item/clothing/head/chaperon/dropped(mob/user)
	icon_state = "[soft_type]soft"
	name = "brown chaperon"
	flipped = FALSE
	return ..()

/obj/item/clothing/head/chaperon/verb/flipcap()
	set category = "Object"
	set name = "flip hat"

	flip(usr)

/obj/item/clothing/head/chaperon/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	flip(user)
	return TRUE


/obj/item/clothing/head/chaperon/proc/flip(mob/user)
	if(!user.incapacitated(allow_crit = TRUE))
		src.flipped = !src.flipped
		if(src.flipped)
			name = "brown liripipe"
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, span_notice("You flip the hat into a liripipe."))
		else
			name = "brown chaperon"
			icon_state = "[soft_type]soft"
			to_chat(user, span_notice("You flip the hat into a chaperon."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/chaperon/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the hat to flip it to be a [flipped ? "chaperon" : "liripipe"].")

/obj/item/clothing/head/chaperon/red
	name = "red chaperon"
	desc = "A fancy cloth hat that can be worn either folded up atop ones head (chaperon) or as a hood (liripipe). This one's red."
	icon_state = "chaperonredsoft"
	soft_type = "chaperonred"

/obj/item/clothing/head/chaperon/red/flip(mob/user)
	if(!user.incapacitated(allow_crit = TRUE))
		src.flipped = !src.flipped
		if(src.flipped)
			name = "red liripipe"
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, span_notice("You flip the hat into a liripipe."))
		else
			name = "red chaperon"
			icon_state = "[soft_type]soft"
			to_chat(user, span_notice("You flip the hat into a chaperon."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/chaperon/red/dropped(mob/user)
	icon_state = "[soft_type]soft"
	name = "red chaperon"
	flipped = FALSE
	return ..()

/obj/item/clothing/head/chaperon/blue
	name = "blue chaperon"
	desc = "A fancy cloth hat that can be worn either folded up atop ones head (chaperon) or as a hood (liripipe). This one's blue."
	icon_state = "chaperonbluesoft"
	soft_type = "chaperonblue"

/obj/item/clothing/head/chaperon/blue/flip(mob/user)
	if(!user.incapacitated(allow_crit = TRUE))
		src.flipped = !src.flipped
		if(src.flipped)
			name = "blue liripipe"
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, span_notice("You flip the hat into a liripipe."))
		else
			name = "blue chaperon"
			icon_state = "[soft_type]soft"
			to_chat(user, span_notice("You flip the hat into a chaperon."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/chaperon/blue/dropped(mob/user)
	icon_state = "[soft_type]soft"
	name = "blue chaperon"
	flipped = FALSE
	return ..()

/obj/item/clothing/head/chaperon/green
	name = "green chaperon"
	desc = "A fancy cloth hat that can be worn either folded up atop ones head (chaperon) or as a hood (liripipe). This one's green."
	icon_state = "chaperongreensoft"
	soft_type = "chaperongreen"

/obj/item/clothing/head/chaperon/green/flip(mob/user)
	if(!user.incapacitated(allow_crit = TRUE))
		src.flipped = !src.flipped
		if(src.flipped)
			name = "brown liripipe"
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, span_notice("You flip the hat into a liripipe."))
		else
			name = "brown chaperon"
			icon_state = "[soft_type]soft"
			to_chat(user, span_notice("You flip the hat into a chaperon."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/chaperon/green/dropped(mob/user)
	icon_state = "[soft_type]soft"
	name = "green chaperon"
	flipped = FALSE
	return ..()
