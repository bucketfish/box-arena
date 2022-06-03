extends TextureButton

export var button_text: String
export var nextmenu: String
export var control_button: bool

onready var label = $Label
onready var key = $key
onready var keytext = $key/Sprite/key
onready var keyhighlight = $key/Sprite/Highlight

signal goto_screen(name)

var selecting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = button_text
	key.visible = control_button
	prep_button()
	
func prep_button():
	if !control_button:
		return
		
	if control_button in Options.keybinds:
		InputMap.action_erase_event(button_text, InputMap.get_action_list(button_text)[0])
		
		var event = InputEventKey.new()
		event.scancode = Options.keybinds(button_text)
		InputMap.action_add_event(button_text, event)

	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
		"Shift": "⇧",
		"Tab": "↹"
		}
		
	var keystroke = InputMap.get_action_list(button_text)[0].as_text()
	if keystroke in thing.keys():
		keystroke = thing[keystroke]
			
	keytext.text = keystroke.to_lower()


func _on_play_pressed():
	if nextmenu:
		emit_signal("goto_screen", nextmenu)
		
	if control_button:
		selecting = true
		release_focus()
		keytext.text = "?"
		keyhighlight.visible = true
		
func _input(event):
	if event is InputEventKey && selecting:
		selecting = false
		InputMap.action_erase_event(button_text, InputMap.get_action_list(button_text)[0])
		InputMap.action_add_event(button_text, event)
		prep_button()
		
		
		yield(get_tree().create_timer(0.01), "timeout")
		keyhighlight.visible = false
		grab_focus()
