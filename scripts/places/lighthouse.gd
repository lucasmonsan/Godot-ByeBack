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
