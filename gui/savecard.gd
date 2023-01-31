extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var highlight = $box/highlight
onready var weapon = $box/player/weapon
onready var health = $box/VBoxContainer/hbox/value
onready var energy = $box/VBoxContainer/hbox2/value
onready var timer = $box/VBoxContainer/hbox3/value
onready var tween = $Tween
onready var box = $box
onready var delete_text = $delete/text
onready var delete_timer = $delete/delete_timer
onready var delete_tween = $delete_tween
onready var delete = $delete

onready var base = get_node("/root/base")

export var save_num: int

onready var time_to_delete = 2.0
var deleting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	box.rect_position = Vector2(0, 0)
	delete.rect_position = Vector2(0, -128)

func display_thumbnail(data):
	"""
	data = {
		"weapon": "weapon name",
		"health": 0,
		"max_health": 0,
		"energy": 0,
		"timer": 000000
	}
	"""
	weapon.texture = load("res://assets/items/" + data["weapon"] + ".png")
	health.text = str(data["health"]) + '/' + str(data["max_health"])
	energy.text = str(data["energy"])
	timer.text = Functions.make_time(data["timer"])
	print("A?")
	
	
func display_none():
	print("IMPLEMENT THIS!!!")
	pass

func _process(delta):
	if Input.is_action_pressed("delete"):
		if !deleting:
			start_deleting()
		deleting = true
		
	else:
		if deleting:
			stop_deleting()
		deleting = false
		
		
func start_deleting():
	delete_timer.wait_time = time_to_delete
	delete_text.bbcode_text = "[center][turncolor chars=32 color=#ffc0c0 time=%d]hold DELETE to delete this save![/turncolor][/center]" % time_to_delete
	delete_timer.start()
	


func _on_delete_timer_timeout():
	delete_text.bbcode_text = "[center][color=#ffc0c0]hold DELETE to delete this save![/color][/center]"
	
	# delete the thing

	
func stop_deleting():
	delete_text.bbcode_text = "[center]hold DELETE to delete this save![/center]"
	delete_timer.stop()



func _on_save_focus_entered():
	highlight.visible = true
	set_process(true)
	
	tween.interpolate_property(box, "rect_position", box.rect_position, Vector2(0, -32), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	delete_tween.interpolate_property(delete, "rect_position", delete.rect_position, Vector2(0, -24), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.start()
	delete_tween.start()
	

func _on_save_focus_exited():
	highlight.visible = false
	set_process(false)
	tween.interpolate_property(box, "rect_position", box.rect_position, Vector2(0, 0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	delete_tween.interpolate_property(delete, "rect_position", delete.rect_position, Vector2(0, -128), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	delete_tween.start()



func _on_save_pressed():
	base.mainmenu.save_selected(save_num)
