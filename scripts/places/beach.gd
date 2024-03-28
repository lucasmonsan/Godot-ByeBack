extends CanvasLayer

func _ready():
	GAME.touch = false
	if (!SFX.sea.playing): SFX._in(SFX.sea)
	for child in get_children(): child.modulate = Color("#FFF0")
	for child in get_children():
		if (GAME.last_place == "lighthouse"): GAME._place_enter("bottom", child)
		await get_tree().create_timer(0.05).timeout
	GAME.touch = true

#-----------------------------------------------------------------------------------------------------------------#

func _on_to_lighthouse_pressed():
	GAME.touch = false
	SFX.click.play()
	GAME.last_place = "beach"
	for child in get_children(): GAME._place_exit("bottom", child)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/places/lighthouse.tscn")
