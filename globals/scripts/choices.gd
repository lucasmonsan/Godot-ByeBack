extends CanvasLayer

func _ready(): for child in get_children(): child.modulate = Color("#FFF0")

func _process(_delta):
	for child in get_children():
		if (child.modulate == Color("FFF0")) and (child.visible): child.visible = false
		elif (child.modulate != Color("FFF0")) and (!child.visible): child.visible = true

#-----------------------------------------------------------------------------------------------------------------#

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
	
	TWN._quad($buttons, "position", Vector2($buttons.position.x, ($buttons.position.y - 64)), 0.5)
	TWN._linear($buttons, "modulate", Color("FFF"), 0.5)
	TWN._linear($grayout, "modulate", Color("FFFC"), 0.5)
	GAME.touch = true

func _interrupt(option):
	GAME._once()
	GAME.touch = false
	$interrupt.modulate = Color("#FFF0")
	$interrupt.position.y += 64
	$interrupt.text = option
	TWN._quad($interrupt, "position", Vector2($interrupt.position.x, ($interrupt.position.y - 64)), 0.5)
	TWN._linear($interrupt, "modulate", Color("FFF"), 0.5)
	GAME.touch = true
	await get_tree().create_timer(3).timeout
	if (!GAME.interrupt): _on_interrupt_pressed(true)

func _on_option_1_pressed(): if (GAME.touch): _after_click(1)
func _on_option_2_pressed(): if (GAME.touch): _after_click(2)
func _on_option_3_pressed(): if (GAME.touch): _after_click(3)
func _on_option_4_pressed(): if (GAME.touch): _after_click(4)

func _after_click(aux_choiced):
	GAME._once()
	GAME.touch = false
	SFX.click.play()
	GAME.choice = aux_choiced
	TWN._linear($buttons, "position", Vector2($buttons.position.x, ($buttons.position.y + 64)), 0.5)
	TWN._linear($buttons, "modulate", Color("FFF0"), 0.5)
	TWN._linear($grayout, "modulate", Color("FFF0"), 0.5)
	await get_tree().create_timer(0.75).timeout
	$buttons.position.y -= 64
	GAME._next()

func _full_page():
	GAME._once()
	for child in get_children(): child.modulate = Color("#FFF0")
	TWN._linear($full_page, "modulate", Color("FFF"), 0.5)
	await get_tree().create_timer(0.4).timeout
	GAME.touch = true

func _on_full_page_pressed(): if (GAME.touch):
	GAME.touch = false
	SFX.click.play()
	TWN._linear($full_page, "modulate", Color("FFF0"), 0.5)
	await get_tree().create_timer(0.5).timeout
	GAME._next()

func _on_interrupt_pressed(timer = false): if (GAME.touch):
	GAME._once()
	GAME.touch = false
	TWN._quad($interrupt, "position", Vector2($interrupt.position.x, ($interrupt.position.y + 64)), 0.5)
	TWN._linear($interrupt, "modulate", Color("FFF0"), 0.5)
	if (!timer):
		SFX.interrupt.play()
		GAME.choice = 0
		GAME.interrupt = true
		GAME._next(1.5)
