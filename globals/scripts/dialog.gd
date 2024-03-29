extends CanvasLayer

var npc = ""
var animation = "empty"

@onready var speech = $ballon/text
@onready var grandpa = $characters/grandpa

func _ready():
	for child in get_children(): child.modulate = Color("FFF0")

func _process(_delta):
	for child in get_children():
		if (child.modulate == Color("FFF0")) and (child.visible): child.visible = false
		elif (child.modulate != Color("FFF0")) and (!child.visible): child.visible = true

#-----------------------------------------------------------------------------------------------------------------#

func _start(text, speed = 0.05):
	GAME._once()
	GAME.interrupt = false
	TWN._linear(speech, "modulate", Color("FFF0"), 0.25)
	await get_tree().create_timer(0.25).timeout
	var array_count = 0
	
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
		
		while (speech.visible_characters < (speech.text.length() - _extract_bbcode_tags(speech.text))) and (!GAME.interrupt):
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
	if (!GAME.interrupt): GAME._next()

func _extract_bbcode_tags(aux_string):
	var tags = ""
	var inside = false
	
	for character in aux_string:
		if (character == "["): inside = true
		if (inside): tags += character
		if (character == "]"): inside = false
	return tags.length()

func _end(speed = 0.5):
	GAME._once()
	for child in get_children(): TWN._linear(child, "modulate", Color("FFF0"), speed)
