extends Node

func _linear(node, property, final, time):
	var my_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	my_tween.tween_property(node, property, final, time)

func _quad(node, property, final, time):
	var my_tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	my_tween.tween_property(node, property, final, time)
