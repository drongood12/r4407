/obj/item/weapon/secstorage/sbriefcase
	name = "secure briefcase"
	icon = 'icons/obj/storage.dmi'
	icon_state = "secure"
	item_state = "sec-case"
	desc = "A large briefcase with a digital locking system."
	flags = FPRINT | TABLEPASS
	force = 8.0
	throw2_speed = 1
	throw2_range = 4
	w_class = 4.0

/obj/item/weapon/secstorage/sbriefcase/New()
	..()
	new /obj/item/weapon/paper(src)
	new /obj/item/weapon/pen(src)

/obj/item/weapon/secstorage/sbriefcase/attack(mob/M as mob, mob/user as mob)
	if ((usr.mutations & 16) && prob(50))
		usr << "\red The [src] slips out of your hand and hits your head."
		usr.bruteloss += 10
		usr.paralysis += 2
		return

	var/t = user:zone_sel.selecting
	if (t == "head")
		if (M.stat < 2 && M.health < 50 && prob(90))
			var/mob/H = M
		// ******* Check
			if ((istype(H, /mob/living/carbon/human) && istype(H, /obj/item/clothing/head) && H.flags & 8 && prob(80)))
				M << "\red The helmet protects you from being hit hard in the head!"
				return
			var/time = rand(2, 6)
			if (prob(75))
				if (M.paralysis < time)// && (!M.ishulk))
					M.paralysis = time
			else
				if (M.stunned < time)// && (!M.ishulk))
					M.stunned = time
			if(M.stat != 2)	M.stat = 1
			for(var/mob/O in viewers(M, null))
				O.show_message(text("\red <B>[] has been knocked unconscious!</B>", M), 1, "\red You hear someone fall.", 2)
		else
			M << text("\red [] tried to knock you unconcious!",user)
			M.eye_blurry += 3

	return
