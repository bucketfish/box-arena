extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var highlight = $box/highlight
onready var newsave_highlight = $new_save/highlight


onready var weapon = $box/player/weapon
onready var health = $box/VBoxContainer/hbox/value
onready var energy = $box/VBoxContainer/hbox2/value
onready var timer = $box/VBoxContainer/hbox3/value
onready var tween = $Tween
onready var box = $box
onready var new_save = $new_save

onready var delete_text = $delete/text
onready var delete_timer = $delete/delete_timer
onready var delete_tween = $delete_tween
onready var delete = $delete
onready var save_label = $box/Label
onready var anim = $AnimationPlayer

onready var base = get_node("/root/base")


onready var card = box

var has_save = false

export var save_num: int

onready var time_to_delete = 1.5
var deleting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight.visible = false
	newsave_highlight.visible = false
	set_process(false)
	save_label.text = "save %d" % (save_num + 1)

func display_thumbnail(data, firsttime = true):
	has_save = true
	if firsttime:
		anim.play("existing")
	
	"""
	data = {
		"weapon": "weapon name",
		"health": 0,
		"max_health": 0,
		"energy": 0,
		"timer": 000000
	}
	"""
	
	if data["weapon"] == "":
		weapon.texture = null
	else:
		weapon.texture = load("res://assets/items/" + data["weapon"] + ".png")
	health.text = str(data["health"]) + '/' + str(data["max_health"])
	energy.text = str(data["energy"])
	timer.text = Functions.make_time(data["timer"])
	
	
	
	
func display_none():
	has_save = false
	anim.play("empty")
	

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
	if has_save:
		delete_timer.wait_time = time_to_delete
		delete_text.bbcode_text = "[center][turncolor chars=32 color=#ffc0c0 time=1.5]hold DELETE to delete this save![/turncolor][/center]" #  % time_to_delete
		delete_timer.start()
	


func _on_delete_timer_timeout():
	delete_text.bbcode_text = "[center][color=#ffc0c0]hold DELETE to delete this save![/color][/center]"
	
	delete_save()

	
func stop_deleting():
	delete_text.bbcode_text = "[center]hold DELETE to delete this save![/center]"
	delete_timer.stop()



func _on_save_focus_entered():
	highlight.visible = true
	newsave_highlight.visible = true
	set_process(true)
	if has_save:
		card = box
	else:
		card = new_save
	
	tween.interpolate_property(card, "rect_position", card.rect_position, Vector2(0, -32), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if has_save:
		delete_tween.interpolate_property(delete, "rect_position", delete.rect_position, Vector2(0, -24), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		delete_tween.start()
	
	tween.start()
	

	

func _on_save_focus_exited():
	highlight.visible = false
	newsave_highlight.visible = false
	set_process(false)
	
	if has_save:
		card = box
	else:
		card = new_save
		
	tween.interpolate_property(card, "rect_position", card.rect_position, Vector2(0, 0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if has_save:
		delete_tween.interpolate_property(delete, "rect_position", delete.rect_position, Vector2(0, -128), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		delete_tween.start()
		
	tween.start()



func _on_save_pressed():
	if has_save:
		base.mainmenu.save_selected(save_num)
	else:
		create_new_save()
		
func create_new_save():
	anim.play_backwards("new_save")
	has_save = true
	yield(anim, "animation_finished")
	delete_tween.interpolate_property(delete, "rect_position", delete.rect_position, Vector2(0, -24), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	delete_tween.start()
	
	
	Persistent.create_save(save_num)
	
	display_thumbnail(Persistent.thumbnails[save_num], false)
	

func delete_save():
	anim.play("new_save")
	has_save = false

	Persistent.delete_save(save_num)
	

