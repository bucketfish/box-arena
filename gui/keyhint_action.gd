extends Control


export var control_button:String

onready var label = $actionname
onready var key = $actionkey
onready var base = get_node("/root/base")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = control_button

func prep_button():
	if !control_button:
		return

	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
		"Shift": "⇧",
		"Tab": "↹"
		}
		
	var keystroke = InputMap.get_action_list(control_button)[0].as_text()
	if keystroke in thing.keys():
		keystroke = thing[keystroke]
			
	key.text = keystroke.to_lower()

func show_button():
	visible = base.canuse[control_button]
