extends CanvasLayer

func _process(_delta):
	if (GAME.day == 1):
		if (GAME.step == 0):
			SFX._out(SFX.title, 2)
			await get_tree().create_timer(2).timeout
			GAME._next()
		elif (GAME.step == 1):
			DIALOG.npc = "grandpa"
			DIALOG._start(["Então...", "Ocê já descobriu por quê só tem estrela no céu de noite?"])
	pass
