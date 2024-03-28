extends CanvasLayer

var npc = ""
var animation = "empty"

@onready var speech = $ballon/text
@onready var grandpa = $characters/grandpa

func _ready():
	visible = false
	for child in get_children(): child.modulate = Color("FFF0")
	
	npc = "grandpa"
	animation = "sad_talk"
	_start(["Ocê num tá pra prosa hoje, né."])

#-----------------------------------------------------------------------------------------------------------------#

func _start(text, speed = 0.05):
	GAME._once()
	TWN._linear(speech, "modulate", Color("FFF0"), 0.25)
	await get_tree().create_timer(0.5).timeout
	var array_count = 0
	visible = true
	
	if (npc == "grandpa"): $name.text = "Vô"
	
	var current_npc = "characters/" + npc
	TWN._linear($characters, "modulate", Color("FFF"), 0.5)
	
	speech.text = "[center]" + text[array_count]
	speech.visible_characters = 0
	speech.visible_ratio = 0
	
	TWN._linear($ballon, "modulate", Color("FFF"), 0.5)
	TWN._linear(speech, "modulate", Color("FFF"), 0.5)
	TWN._linear($name, "modulate", Color("FFF"), 0.5)
	
	while (array_count < text.size()):
		get_node(current_npc).play(animation)
		
		while speech.visible_characters < (speech.text.length() - _extract_bbcode_tags(speech.text)):
			if (speech.visible_characters % 2 == 1): get_node(str(current_npc + "/voice")).play()
			speech.visible_characters += 1
			await get_tree().create_timer(speed).timeout
		
		if (array_count < text.size() -1):
			get_node(current_npc).stop()
			await (get_tree().create_timer(speed * 5).timeout)
			array_count += 1
			speech.text += " " + text[array_count]
		else: break
	
	if (npc != ""): get_node(current_npc).stop()
	GAME._next()

func _extract_bbcode_tags(aux_string):
	var tags = ""
	var inside = false
	
	for character in aux_string:
		if (character == "["): inside = true
		if (inside): tags += character
		if (character == "]"): inside = false
	return tags.length()

func _end(speed = 0.5):
	TWN._linear($name, "modulate", Color("FFF0"), speed)
	TWN._linear($ballon, "modulate", Color("FFF0"), speed)
	TWN._linear($characters, "modulate", Color("FFF0"), speed)
	await get_tree().create_timer(speed).timeout
	visible = false
