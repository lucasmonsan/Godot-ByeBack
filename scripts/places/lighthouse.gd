extends CanvasLayer

func _ready():
	GAME.touch = false
	if (!SFX.sea.playing): SFX._in(SFX.sea)
	for child in get_children(): child.modulate = Color("#FFF0")
	for child in get_children(): 
		GAME._place_enter("top", child)
		await get_tree().create_timer(0.05).timeout
	GAME.touch = true

#-----------------------------------------------------------------------------------------------------------------#

func _on_to_interior_pressed(): if (GAME.touch):
	GAME.touch = false
	SFX.click.play()
	for child in get_children(): GAME._place_exit("zoom_in", child)

func _on_to_beach_pressed(): if (GAME.touch):
	GAME.touch = false
	SFX.click.play()
	GAME.last_place = "lighthouse"
	for child in get_children(): GAME._place_exit("top", child)
	await get_tree().create_timer(0.75).timeout
	get_tree().change_scene_to_file("res://scenes/places/beach.tscn")

#-----------------------------------------------------------------------------------------------------------------#

func _process(_delta):
	if (GAME.day == 1):
		if (GAME.step == 20):
			SFX.bgm_01.play()
			GAME._next(3)
		elif (GAME.step == 21):
			if (GAME.choice == 1):
				DIALOG.animation = "sad_talk"
				DIALOG._start(["Desculpa o vô pela piada.", "Só queria aliviar o clima um pouquinho..."])
			elif (GAME.choice == 2): 
				DIALOG.animation = "normal_talk"
				DIALOG._start(["Aposto que não é o que ocê achava que era antigamente."])
		elif (GAME.step == 22):
			if (GAME.choice == 1):
				DIALOG.animation = "sad_talk"
				DIALOG._start(["Desculpa o vô pela piada.", "Só queria aliviar o clima um pouquinho..."])
			elif (GAME.choice == 2): 
				DIALOG.animation = "normal_talk"
				DIALOG._start(["Aposto que não é o que ocê achava que era antigamente."])
	pass
