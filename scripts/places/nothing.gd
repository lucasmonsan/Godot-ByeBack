extends Node

func _process(_delta):
	if (GAME.day == 1):
		if (GAME.step == 0): GAME._next()
		elif (GAME.step == 1):
			GAME._fg_fade(1.5)
			SFX._out(SFX.title, 2)
			GAME._next(2)
		elif (GAME.step == 2):
			DIALOG.npc = "grandpa"
			DIALOG._start(["Então...", "Ocê já descobriu por quê só tem estrela no céu de noite?"])
		elif (GAME.step == 3):
			if (GAME.interrupt): GAME._next()
			else: CHOICES._start("...", "Descobri sim, vô!")
		elif (GAME.step == 4):
			if (GAME.choice == 1): DIALOG._start(["Ocê num tá pra prosa hoje, né."])
			elif (GAME.choice == 2): DIALOG._start(["Ainda bem que ocê voltô pra me contá então!"])
		elif (GAME.step == 5): 
			CHOICES._full_page()
		elif (GAME.step == 6):
			DIALOG._end()
			GAME._next(1)
		elif (GAME.step == 7):
			GAME.step = 20
			get_tree().change_scene_to_file("res://scenes/places/lighthouse.tscn")
