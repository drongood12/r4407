/proc/playsound(var/atom/source, soundin, vol as num, vary, extrarange as num)
	//Frequency stuff only works with 45kbps oggs.

	switch(soundin)
		if ("shatter") soundin = pick('sound/effects/Glassbr1.ogg','sound/effects/Glassbr2.ogg','sound/effects/Glassbr3.ogg')
		if ("explosion") soundin = pick('sound/effects/Explosion1.ogg','sound/effects/Explosion2.ogg')
		if ("sparks") soundin = pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')
		if ("rustle") soundin = pick('sound/misc/rustle1.ogg','sound/misc/rustle2.ogg','sound/misc/rustle3.ogg','sound/misc/rustle4.ogg','sound/misc/rustle5.ogg')
		if ("punch") soundin = pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg')
		if ("clownstep") soundin = pick('sound/misc/clownstep1.ogg','sound/misc/clownstep2.ogg')
		if ("swing_hit") soundin = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit2.ogg')

	var/sound/S = sound(soundin)
	S.wait = 0 //No queue
	S.channel = 0 //Any channel
	S.volume = vol

	if (vary)
		S.frequency = rand(32000, 55000)
	for (var/mob/M in range(world.view+extrarange, source))
		if (M.client)
			if(isturf(source))
				var/dx = source.x - M.x
				S.pan = max(-100, min(100, dx/8.0 * 100))
			M << S

/mob/proc/playsound_local(var/atom/source, soundin, vol as num, vary, extrarange as num)
	if(!src.client)
		return
	switch(soundin)
		if ("shatter") soundin = pick('sound/effects/Glassbr1.ogg','sound/effects/Glassbr2.ogg','sound/effects/Glassbr3.ogg')
		if ("explosion") soundin = pick('sound/effects/Explosion1.ogg','sound/effects/Explosion2.ogg')
		if ("sparks") soundin = pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')
		if ("rustle") soundin = pick('sound/misc/rustle1.ogg','sound/misc/rustle2.ogg','sound/misc/rustle3.ogg','sound/misc/rustle4.ogg','sound/misc/rustle5.ogg')
		if ("punch") soundin = pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg')
		if ("clownstep") soundin = pick('sound/misc/clownstep1.ogg','sound/misc/clownstep2.ogg')
		if ("swing_hit") soundin = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit2.ogg')

	var/sound/S = sound(soundin)
	S.wait = 0 //No queue
	S.channel = 0 //Any channel
	S.volume = vol

	if (vary)
		S.frequency = rand(32000, 55000)
	if(isturf(source))
		var/dx = source.x - src.x
		S.pan = max(-100, min(100, dx/8.0 * 100))
	src << S

client/verb/Toggle_Soundscape()
	usr:client:no_ambi = !usr:client:no_ambi
	if(usr:client:no_ambi)
		usr << sound('sound/ambience/shipambience.ogg', repeat = 0, wait = 0, volume = 0, channel = 2)
	else
		usr << sound('sound/ambience/shipambience.ogg', repeat = 1, wait = 0, volume = 50, channel = 2)
	usr << "Toggled ambience sound."
	return


/area/Entered(A)
	var/sound = null
	sound = 'sound/ambience/ambigen1.ogg'

	if (ismob(A))

		if (istype(A, /mob/dead/observer)) return
		if (!A:client) return
		//if (A:ear_deaf) return

		if (A && A:client && !A:client:ambience_playing && !A:client:no_ambi) // Constant background noises
			A:client:ambience_playing = 1
			A << sound('sound/ambience/shipambience.ogg', repeat = 1, wait = 0, volume = 50, channel = 2)

		switch(src.name)
			if ("Chapel") sound = pick('sound/ambience/ambicha1.ogg','sound/ambience/ambicha2.ogg','sound/ambience/ambicha3.ogg','sound/ambience/ambicha4.ogg')
			if ("Morgue") sound = pick('sound/ambience/ambimo1.ogg','sound/ambience/ambimo2.ogg')
			if ("Engine Control") sound = pick('sound/ambience/ambieng1.ogg')
			if ("Atmospherics") sound = pick('sound/ambience/ambiatm1.ogg')
			else sound = pick('sound/ambience/ambigen1.ogg','sound/ambience/ambigen2.ogg','sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambigen12.ogg','sound/ambience/ambigen13.ogg','sound/ambience/ambigen14.ogg')

		if (prob(35))
			if(A && A:client && !A:client:played)
				A << sound(sound, repeat = 0, wait = 0, volume = 25, channel = 1)
				A:client:played = 1
				spawn(600)
					if(A && A:client)
						A:client:played = 0
