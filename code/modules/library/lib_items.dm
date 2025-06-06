/* Library Items
 *
 * Contains:
 *		Bookcase
 *		Book
 *		Barcode Scanner
 */

/*
 * Bookcase
 */

//Fallout style bookshelf, simplified until someone adds functional storage and debris, maybe some planks.
/obj/structure/bookshelf
	name = "bookshelf"
	icon = 'icons/fallout/objects/furniture/stationary.dmi'
	icon_state = "book-0"
	desc = "A great place for storing knowledge."
	opacity = 0
	resistance_flags = FLAMMABLE

/obj/structure/bookshelf/New()
	..()
	icon_state = "book-[rand(1,5)]"

/obj/structure/bookcase
	name = "bookcase"
	icon = 'icons/fallout/objects/furniture/stationary.dmi'
	icon_state = "bookempty"
	desc = "A great place for storing knowledge."
	anchored = FALSE
	density = TRUE
	opacity = 0
	resistance_flags = FLAMMABLE
	max_integrity = 200
	var/state = 0
	var/list/allowed_books = list(/obj/item/book, /obj/item/spellbook, /obj/item/storage/book, /obj/item/gun/magic/wand/book, /obj/item/book/granter, /obj/item/healthanalyzer/tribal) //Things allowed in the bookcase

/obj/structure/bookcase/examine(mob/user)
	. = ..()
	if(!anchored)
		. += span_notice("The <i>bolts</i> on the bottom are unsecured.")
	if(anchored)
		. += span_notice("It's secured in place with <b>bolts</b>.")
	switch(state)
		if(0)
			. += span_notice("There's a <b>small crack</b> visible on the back panel.")
		if(1)
			. += span_notice("There's space inside for a <i>wooden</i> shelf.")
		if(2)
			. += span_notice("There's a <b>small crack</b> visible on the shelf.")

/obj/structure/bookcase/Initialize(mapload)
	. = ..()
	if(!mapload)
		return
	state = 2
	icon_state = "book-0"
	anchored = TRUE
	for(var/obj/item/I in loc)
		if(istype(I, /obj/item/book))
			I.forceMove(src)
	update_icon()

/obj/structure/bookcase/attackby(obj/item/I, mob/user, params)
	switch(state)
		if(0)
			if(istype(I, /obj/item/wrench))
				if(I.use_tool(src, user, 20, volume=50))
					to_chat(user, span_notice("You wrench the frame into place."))
					anchored = TRUE
					state = 1
			if(istype(I, /obj/item/crowbar))
				if(I.use_tool(src, user, 20, volume=50))
					to_chat(user, span_notice("You pry the frame apart."))
					deconstruct(TRUE)

		if(1)
			if(istype(I, /obj/item/stack/sheet/mineral/wood))
				var/obj/item/stack/sheet/mineral/wood/W = I
				if(W.get_amount() >= 2)
					W.use(2)
					to_chat(user, span_notice("You add a shelf."))
					state = 2
					icon_state = "book-0"
			if(istype(I, /obj/item/wrench))
				I.play_tool_sound(src, 100)
				to_chat(user, span_notice("You unwrench the frame."))
				anchored = FALSE
				state = 0

		if(2)
			var/datum/component/storage/STR = I.GetComponent(/datum/component/storage)
			if(is_type_in_list(I, allowed_books))
				if(!user.transferItemToLoc(I, src))
					return
				update_icon()
			else if(STR)
				for(var/obj/item/T in I.contents)
					if(istype(T, /obj/item/book) || istype(T, /obj/item/spellbook))
						STR.remove_from_storage(T, src)
				to_chat(user, span_notice("You empty \the [I] into \the [src]."))
				update_icon()
			else if(istype(I, /obj/item/pen))
				if(!user.is_literate())
					to_chat(user, span_notice("You scribble illegibly on the side of [src]!"))
					return
				var/newname = stripped_input(user, "What would you like to title this bookshelf?")
				if(!user.canUseTopic(src, BE_CLOSE))
					return
				if(!newname)
					return
				else
					name = "bookcase ([sanitize(newname)])"
			else if(istype(I, /obj/item/crowbar))
				if(contents.len)
					to_chat(user, span_warning("You need to remove the books first!"))
				else
					I.play_tool_sound(src, 100)
					to_chat(user, span_notice("You pry the shelf out."))
					new /obj/item/stack/sheet/mineral/wood(drop_location(), 2)
					state = 1
					icon_state = "bookempty"
			else
				return ..()

/obj/structure/bookcase/on_attack_hand(mob/living/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(. || !istype(user))
		return
	if(contents.len)
		var/obj/item/book/choice = input("Which book would you like to remove from the shelf?") as null|obj in contents
		if(choice)
			if(!CHECK_MOBILITY(user, MOBILITY_USE) || !in_range(loc, user))
				return
			if(ishuman(user))
				if(!user.get_active_held_item())
					user.put_in_hands(choice)
			else
				choice.forceMove(drop_location())
			update_icon()

/obj/structure/bookcase/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(!length(contents))
		to_chat(user, span_warning("It's empty!"))
		return
	var/obj/item/book/choice = input("Which book would you like to read?") as null|obj in contents
	if(choice)
		if(!istype(choice)) //spellbook, cult tome, or the one weird bible storage
			to_chat(user,"A mysterious force is keeping you from reading that.")
			return
		choice.attack_ghost(user)

/obj/structure/bookcase/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(loc, 4)
	for(var/obj/item/book/B in contents)
		B.forceMove(get_turf(src))
	qdel(src)


/obj/structure/bookcase/update_icon_state()
	icon_state = "book-[min(length(contents), 5)]"


/obj/structure/bookcase/manuals/medical
	name = "medical manuals bookcase"

/obj/structure/bookcase/manuals/medical/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/medical_cloning(src)
	update_icon()


/obj/structure/bookcase/manuals/engineering
	name = "engineering manuals bookcase"

/obj/structure/bookcase/manuals/engineering/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/engineering_construction(src)
	new /obj/item/book/manual/wiki/engineering_hacking(src)
	new /obj/item/book/manual/wiki/engineering_guide(src)
	new /obj/item/book/manual/wiki/engineering_singulo_tesla(src)
	new /obj/item/book/manual/wiki/robotics_cyborgs(src)
	update_icon()


/obj/structure/bookcase/manuals/research_and_development
	name = "\improper R&D manuals bookcase"

/obj/structure/bookcase/manuals/research_and_development/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/research_and_development(src)
	update_icon()


/*
 * Book
 */
/obj/item/book
	name = "book"
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	desc = "Crack it open, inhale the musk of its pages, and learn something new."
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL	 //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb = list("bashed", "whacked", "educated")
	resistance_flags = FLAMMABLE
	var/dat				//Actual page content
	var/due_date = 0	//Game time in 1/10th seconds
	var/author			//Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	var/unique = 0		//0 - Normal book, 1 - Should not be treated as normal book, unable to be copied, unable to be modified
	var/title			//The real name of the book.
	var/window_size = null // Specific window size for the book, i.e: "1920x1080", Size x Width

/obj/item/book/attack_self(mob/user)
	if(is_blind(user))
		to_chat(user, span_warning("As you are trying to read, you suddenly feel very stupid!"))
		return
	if(ismonkey(user))
		to_chat(user, span_notice("You skim through the book but can't comprehend any of it."))
		return
	if(dat)
		show_to(user)
		user.visible_message("[user] opens a book titled \"[title]\" and begins reading intently.")
	else
		to_chat(user, span_notice("This book is completely blank!"))

/obj/item/book/attack_ghost(mob/dead/observer/O)
	. = ..()
	show_to(O)

/obj/item/book/proc/show_to(mob/user)
	user << browse("<TT><I>Penned by [author].</I></TT> <BR>" + "[dat]", "window=book[window_size != null ? ";size=[window_size]" : ""]")

/obj/item/book/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/pen))
		if(is_blind(user))
			to_chat(user, span_warning(" As you are trying to write on the book, you suddenly feel very stupid!"))
			return
		if(unique)
			to_chat(user, span_warning("These pages don't seem to take the ink well! Looks like you can't modify it."))
			return
		var/literate = user.is_literate()
		if(!literate)
			to_chat(user, span_notice("You scribble illegibly on the cover of [src]!"))
			return
		var/choice = input("What would you like to change?") in list("Title", "Contents", "Author", "Cancel")
		if(!user.canUseTopic(src, BE_CLOSE, literate))
			return
		switch(choice)
			if("Title")
				var/newtitle = reject_bad_text(stripped_input(user, "Write a new title:"))
				if(!user.canUseTopic(src, BE_CLOSE, literate))
					return
				if (length(newtitle) > 20)
					to_chat(user, "That title won't fit on the cover!")
					return
				if(!newtitle)
					to_chat(user, "That title is invalid.")
					return
				else
					name = newtitle
					title = newtitle
			if("Contents")
				var/content = stripped_input(user, "Write your book's contents (HTML NOT allowed):","","",8192)
				if(!user.canUseTopic(src, BE_CLOSE, literate))
					return
				if(!content)
					to_chat(user, "The content is invalid.")
					return
				else
					dat += content
			if("Author")
				var/newauthor = stripped_input(user, "Write the author's name:")
				if(!user.canUseTopic(src, BE_CLOSE, literate))
					return
				if(!newauthor)
					to_chat(user, "The name is invalid.")
					return
				else
					author = newauthor
			else
				return

	else if(istype(I, /obj/item/barcodescanner))
		var/obj/item/barcodescanner/scanner = I
		if(!scanner.computer)
			to_chat(user, "[I]'s screen flashes: 'No associated computer found!'")
		else
			switch(scanner.mode)
				if(0)
					scanner.book = src
					to_chat(user, "[I]'s screen flashes: 'Book stored in buffer.'")
				if(1)
					scanner.book = src
					scanner.computer.buffer_book = name
					to_chat(user, "[I]'s screen flashes: 'Book stored in buffer. Book title stored in associated computer buffer.'")
				if(2)
					scanner.book = src
					for(var/datum/borrowbook/b in scanner.computer.checkouts)
						if(b.bookname == name)
							scanner.computer.checkouts.Remove(b)
							to_chat(user, "[I]'s screen flashes: 'Book stored in buffer. Book has been checked in.'")
							return
					to_chat(user, "[I]'s screen flashes: 'Book stored in buffer. No active check-out record found for current title.'")
				if(3)
					scanner.book = src
					for(var/obj/item/book in scanner.computer.inventory)
						if(book == src)
							to_chat(user, "[I]'s screen flashes: 'Book stored in buffer. Title already present in inventory, aborting to avoid duplicate entry.'")
							return
					scanner.computer.inventory.Add(src)
					to_chat(user, "[I]'s screen flashes: 'Book stored in buffer. Title added to general inventory.'")

	else if(istype(I, /obj/item/kitchen/knife) || istype(I, /obj/item/wirecutters))
		to_chat(user, span_notice("You begin to carve out [title]..."))
		if(do_after(user, 30, target = src))
			to_chat(user, span_notice("You carve out the pages from [title]! You didn't want to read it anyway."))
			var/obj/item/storage/book/B = new
			B.name = src.name
			B.title = src.title
			B.icon_state = src.icon_state
			if(user.is_holding(src))
				qdel(src)
				user.put_in_hands(B)
				return
			else
				B.forceMove(drop_location())
				qdel(src)
				return
		return
	else
		..()


/*
 * Barcode Scanner
 */
/obj/item/barcodescanner
	name = "barcode scanner"
	icon = 'icons/obj/library.dmi'
	icon_state ="scanner"
	desc = "A fabulous tool if you need to scan a barcode."
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/obj/machinery/computer/libraryconsole/bookmanagement/computer	//Associated computer - Modes 1 to 3 use this
	var/obj/item/book/book			//Currently scanned book
	var/mode = 0							//0 - Scan only, 1 - Scan and Set Buffer, 2 - Scan and Attempt to Check In, 3 - Scan and Attempt to Add to Inventory

/obj/item/barcodescanner/attack_self(mob/user)
	mode += 1
	if(mode > 3)
		mode = 0
	to_chat(user, "[src] Status Display:")
	var/modedesc
	switch(mode)
		if(0)
			modedesc = "Scan book to local buffer."
		if(1)
			modedesc = "Scan book to local buffer and set associated computer buffer to match."
		if(2)
			modedesc = "Scan book to local buffer, attempt to check in scanned book."
		if(3)
			modedesc = "Scan book to local buffer, attempt to add book to general inventory."
		else
			modedesc = "ERROR"
	to_chat(user, " - Mode [mode] : [modedesc]")
	if(computer)
		to_chat(user, "<font color=green>Computer has been associated with this unit.</font>")
	else
		to_chat(user, "<font color=red>No associated computer found. Only local scans will function properly.</font>")
	to_chat(user, "\n")
