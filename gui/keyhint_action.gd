extends Control


export var control_button:String

onready var label = $actionname
onready var key = $actionkey
onready var base = get_node("/root/base")

export var show_label = true
export var highlight = false
export var check_canuse = true
export var autoprep = false
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = control_button
	
	if !show_label:
		label.visible = false
		
	if autoprep:
		prep_button()

func prep_button():
	if !control_button:
		return

	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
		"Shift": "⇧",
		"Tab": "⇥"
		}
		
	var keystroke = InputMap.get_action_list(control_button)[0].as_text()
	print(keystroke)
	if keystroke in thing.keys():
		keystroke = thing[keystroke]
			
	key.text = keystroke.to_lower()

func show_button():
	if check_canuse:
		visible = base.canuse[control_button]
	else:
		visible = true

func _input(event):
	if highlight:
		if Input.is_action_pressed(control_button):
			key.self_modulate = "#000000"
			
		if Input.is_action_just_released(control_button):
			key.self_modulate = "#ffffff"
