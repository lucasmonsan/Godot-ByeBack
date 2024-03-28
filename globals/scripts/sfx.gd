extends Node

@onready var title = $music/title
@onready var bgm_01 = $music/bgm01

@onready var wind_strong = $ambience/wind_strong
@onready var forest = $ambience/forest
@onready var bell = $ambience/bell
@onready var sea = $ambience/sea

@onready var click = $ui/click

#-----------------------------------------------------------------------------------------------------------------#

func _process(_delta):
	if (title.volume_db == -80 and title.playing): title.stop()
	if (bgm_01.volume_db == -80 and bgm_01.playing): bgm_01.stop()
	
	if (forest.volume_db <= -80 and forest.playing): forest.stop()
	if (sea.volume_db <= -80 and sea.playing): sea.stop()

#-----------------------------------------------------------------------------------------------------------------#

func _in(node, time = 1):
	GAME._once()
	node.volume_db = -64
	node.play()
	get_tree().create_tween().tween_property(node, "volume_db", 0, time)
func _out(node, time = 0.75):
	GAME._once()
	get_tree().create_tween().tween_property(node, "volume_db", -80, time)
	await get_tree().create_timer(time).timeout
	node.stop()
