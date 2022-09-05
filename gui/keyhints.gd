extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_keys()
	update_keyhints()

func update_keys():
	propagate_call("prep_button")
	
func update_keyhints():
	propagate_call("show_button")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
