extends CanvasLayer

func _ready(): 
	visible = false
	$full_page.visible = false
	for child in get_children(): child.modulate = Color("#FFF0")

func _start(option1, option2="", option3="", option4=""):
	GAME._once()
	GAME.touch = false
	
	for child in get_children(): child.modulate = Color("#FFF0")
	$buttons.position.y += 64
	
	$buttons/option1.text = option1
	$buttons/option2.text = option2
	$buttons/option3.text = option3 
	$buttons/option4.text = option4
	
	$buttons/option2.visible = (option2 != "")
	$buttons/option3.visible = (option3 != "")
	$buttons/option4.visible = (option4 != "")
	
	visible = true
	TWN._quad($buttons, "position", Vector2($buttons.position.x, ($buttons.position.y - 64)), 0.5)
	TWN._linear($buttons, "modulate", Color("FFF"), 0.5)
	TWN._linear($grayout, "modulate", Color("FFFC"), 0.5)
	GAME.touch = true

func _on_option_1_pressed(): if (GAME.touch):
	SFX.click.play()
	_after_click($buttons/option1.text)
func _on_option_2_pressed(): if (GAME.touch):
	SFX.click.play()
	_after_click($buttons/option2.text)
func _on_option_3_pressed(): if (GAME.touch):
	SFX.click.play()
	_after_click($buttons/option3.text)
func _on_option_4_pressed(): if (GAME.touch):
	SFX.click.play()
	_after_click($buttons/option4.text)

func _after_click(aux_choiced):
	GAME._once()
	GAME.touch = false
	GAME.choice = aux_choiced
	TWN._linear($buttons, "position", Vector2($buttons.position.x, ($buttons.position.y + 64)), 0.5)
	TWN._linear($buttons, "modulate", Color("FFF0"), 0.5)
	await get_tree().create_timer(0.75).timeout
	$buttons.position.y -= 64
	visible = false
	GAME._next()

func _full_page():
	GAME._once()
	for child in get_children(): child.modulate = Color("#FFF0")
	visible = true
	$full_page.visible = true
	TWN._linear($full_page, "modulate", Color("FFF"), 0.5)
	await get_tree().create_timer(0.4).timeout
	GAME.touch = true

func _on_btn_full_page_pressed(): if (GAME.touch):
	GAME.touch = false
	SFX.click.play()
	TWN._linear($full_page, "modulate", Color("FFF0"), 0.5)
	await get_tree().create_timer(0.5).timeout
	$full_page.visible = false
	GAME._next()
