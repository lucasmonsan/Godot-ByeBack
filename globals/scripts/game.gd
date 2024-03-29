extends Control

func _ready():
	$bg/ColorRect.color = Color(PALETTE.white)
	$fg/ColorRect.color = Color(PALETTE.black)

func _process(_delta): $debug/Label.text = "step: " + str(GAME.step)

#-----------------------------------------------------------------------------------------------------------------#

func _change_bg(new_color): get_tree().create_tween().tween_property($bg/ColorRect, "color", new_color, 1)
func _change_fg(new_color): get_tree().create_tween().tween_property($fg/ColorRect, "color", new_color, 1)
func _fg_fade(speed = 1.0): 
	if ($fg/ColorRect.visible):
		get_tree().create_tween().tween_property($fg/ColorRect, "modulate", Color("FFF0"), speed)
		await get_tree().create_timer(speed).timeout
		$fg/ColorRect.visible = false
	else:
		$fg/ColorRect.visible = true
		get_tree().create_tween().tween_property($fg/ColorRect, "modulate", Color("FFF"), speed)

#-----------------------------------------------------------------------------------------------------------------#

var day = 1
var step = 1
var choice = ""
var touch = false

func _once():
	touch = false
	if step >= 0: step = step * -1
	else: print("_once: valor negativo")

func _next():
	if step < 0: step = (step * -1) + 1
	else: step += 1

#-----------------------------------------------------------------------------------------------------------------#

var last_place = ""

func _place_enter(direction, node, speed = 1):
	var my_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	if (direction == "top"):
		node.position.y = node.position.y - 128
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "position", Vector2(node.position.x, node.position.y+128), speed)
	elif (direction == "right"):
		node.position.x = node.position.x + 128
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "position", Vector2(node.position.x-128, node.position.y), speed)
	elif (direction == "bottom"):
		node.position.y = node.position.y + 128
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "position", Vector2(node.position.x, node.position.y-128), speed)
	elif (direction == "left"):
		node.position.x = node.position.x - 128
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "position", Vector2(node.position.x+128, node.position.y), speed)
	elif (direction == "zoom_in"):
		node.scale = Vector2(0, 0)
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "scale", Vector2(1, 1), speed)
	elif (direction == "zoom_out"):
		node.scale = Vector2(2, 2)
		my_tween.tween_property(node, "modulate", Color("#FFF"), speed)
		my_tween.parallel().tween_property(node, "scale", Vector2(1, 1), speed)

func _place_exit(direction, node, speed = 0.5):
	var my_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	if (direction == "top"):
		my_tween.tween_property(node, "position", Vector2(node.position.x, node.position.y-128), speed)
	elif (direction == "right"):
		my_tween.tween_property(node, "position", Vector2(node.position.x+128, node.position.y), speed)
	elif (direction == "bottom"):
		my_tween.tween_property(node, "position", Vector2(node.position.x, node.position.y+128), speed)
	elif (direction == "left"):
		my_tween.tween_property(node, "position", Vector2(node.position.x-128, node.position.y), speed)
	elif (direction == "zoom_in"):
		my_tween.tween_property(node, "scale", Vector2(2, 2), speed)
	elif (direction == "zoom_out"):
		my_tween.tween_property(node, "scale", Vector2(0, 0), speed)
	my_tween.parallel().tween_property(node, "modulate", Color("#FFF0"), speed)

#-----------------------------------------------------------------------------------------------------------------#
