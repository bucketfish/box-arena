extends TextureButton

export var button_text: String
export var nextmenu: String
export var control_button: bool


onready var label = $Label
onready var key = $key
onready var keytext = $key/Sprite/key

signal goto_screen(name)

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = button_text
	key.visible = control_button
	
	if control_button:
		var thing = {
			"Left": "←",
			"Right":"→",
			"Up":"↑",
			"Down":"↓",
			"Shift": "⇧",
			"Tab": "↹"
		}
		
		print(InputMap.get_action_list(button_text)[0])
		print(button_text)
		
		var keystroke = InputMap.get_action_list(button_text)[0].as_text()
		print(keystroke)
		if keystroke in thing.keys():
			keystroke = thing[keystroke]
			
		keytext.text = keystroke.to_lower()
		print(keystroke)


func _on_play_pressed():
	if nextmenu:
		emit_signal("goto_screen", nextmenu)
