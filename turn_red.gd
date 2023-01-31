tool
extends RichTextEffect
class_name RichTextTurnColor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bbcode = "turncolor"

# Called when the node enters the scene tree for the first time.
func _init():
	resource_name = "RichTextTurnColor"
	
func _process_custom_fx(char_fx):
	var speed = char_fx.env.get("time", 2.0) # time to turn entire text into the color
	var chars = char_fx.env.get("chars", 10)
	var color = char_fx.env.get("color", "#F48282")
	
	if speed * (float(char_fx.relative_index) / chars) < char_fx.elapsed_time:
		char_fx.color = color
		return true
	
	
	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
