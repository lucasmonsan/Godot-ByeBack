extends CanvasLayer

func _ready(): 
	GAME._fg_fade()
	SFX.title.play()

func _on_start_pressed(): 
	GAME._fg_fade()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/places/nothing.tscn")
