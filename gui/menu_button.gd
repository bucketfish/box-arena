extends TextureButton

export var button_text: String
export var nextmenu: String
export var control_button: bool
export var slider_button: bool

onready var label = $Label
onready var key = $key
onready var keytext = $key/Sprite/key
onready var keyhighlight = $key/Sprite/Highlight

onready var left = $left
onready var right = $right

onready var left_tween = $left_tween
onready var right_tween = $right_tween
onready var clickaudio = $clickaudio
onready var focusaudio = $focusaudio


signal goto_screen(name)

var selecting = false
var slider_val = 5

var clicked_on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	label.text = button_text + ": 5" if slider_button else button_text
	
	key.visible = control_button
	left.visible = slider_button
	right.visible = slider_button
		
	prep_button()
	
func prep_button():
	if !control_button && !slider_button:
		return
		
	if button_text in Options.keybinds:
		InputMap.action_erase_event(button_text, InputMap.get_action_list(button_text)[0])
		
		var event = InputEventKey.new()
		event.scancode = Options.keybinds[button_text]
		InputMap.action_add_event(button_text, event)

	if control_button:
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
	
	if button_text in Options.config && slider_button:
		slider_val = Options.config[button_text]
		label.text = button_text + ": " + str(slider_val)
		

func _on_play_pressed():
	clickaudio.play()
	
	clicked_on = true
	
	if nextmenu:
		emit_signal("goto_screen", nextmenu)
		
	if control_button:
		selecting = true
		release_focus()
		keytext.text = "?"
		keyhighlight.visible = true
	
		
func _input(event):
	if event is InputEventKey && selecting:
		clickaudio.play()
		clicked_on = true
		
		selecting = false
		InputMap.action_erase_event(button_text, InputMap.get_action_list(button_text)[0])
		InputMap.action_add_event(button_text, event)
		prep_button()
		
		Options.keybinds[button_text] = event.scancode
		
		
		yield(get_tree().create_timer(0.01), "timeout")
		keyhighlight.visible = false
		grab_focus()
		
	var gotime = 0.07
	if Input.is_action_just_pressed("ui_left") && has_focus() && slider_button:
		clickaudio.play()
		slider_val = max(0, slider_val - 1)
		label.text = button_text + ": " + str(slider_val)
		
		left_tween.interpolate_property(left, "rect_position:x", left.rect_position.x,-78, gotime)
		left_tween.start()
		yield(left_tween, "tween_completed")
		left_tween.interpolate_property(left, "rect_position:x", left.rect_position.x,-62, gotime)
		left_tween.start()
		
		Options.config[button_text] = slider_val
#		yield(left_tween, "tween_completed")
		
	elif Input.is_action_just_pressed("ui_right") && has_focus() && slider_button:
		clickaudio.play()
		slider_val = min(10, slider_val + 1)
		label.text = button_text + ": " + str(slider_val)
		
		
		right_tween.interpolate_property(right, "rect_position:x", right.rect_position.x, 578, gotime)
		right_tween.start()
		yield(right_tween, "tween_completed")
		right_tween.interpolate_property(right, "rect_position:x", right.rect_position.x, 562, gotime)
		right_tween.start()
		
		Options.config[button_text] = slider_val
		


func _on_play_focus_exited():
	if !clicked_on:
		focusaudio.play()


func _on_play_focus_entered():
	clicked_on = false
