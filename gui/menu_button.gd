extends TextureButton

export var button_text: String
export var nextmenu: String
export var control_button: bool


onready var label = $Label

signal goto_screen(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = button_text




func _on_play_pressed():
	if nextmenu:
		emit_signal("goto_screen", nextmenu)
