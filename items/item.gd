extends Node2D

export var itemname:String
onready var label = $label/label
onready var anim = $AnimationPlayer
onready var sprite = $sprite
onready var player = get_node("/root/base/player")
onready var base = get_node("/root/base")
onready var tween = $Tween

var isitem = false setget is_show

func _ready():
	# set up the label
	label.bbcode_enabled = true
	label.bbcode_text = "[center]" + itemname
	sprite.rotation_degrees = randi()%360+1 # random rotation!

	# set up sprite texture from sprite name
	sprite.texture = load("res://assets/items/" + itemname + ".png")

# 'isitem' setget; decides whether the item should be highlighted
func is_show(val):
	if val && !isitem:
		anim.play("highlight")
		isitem = true
	elif !val && isitem:
		anim.play_backwards("highlight")
		isitem = false
	else:
		isitem = val


# and unhighlight it if the player is leaving the item area
func _on_Area2D_area_exited(area):
	if area.is_in_group("player_pickup"):
		is_show(false)

# picking up items
func _input(event):
	if Input.is_action_just_pressed("pickup") && isitem && base.state != "pause":
		anim.play_backwards("highlight")
		Persistent.carrying.insert(0, itemname)
		Persistent.sort_inv(Persistent.carrying)
		
		Persistent.places[Persistent.coords].erase(itemname)
		
		# item disappearing animation
		tween.interpolate_property(self, "global_position",
				self.global_position, player.global_position, 0.1,
				Tween.TRANS_LINEAR)
		tween.start()
		yield(tween, "tween_all_completed")
		
		queue_free()
