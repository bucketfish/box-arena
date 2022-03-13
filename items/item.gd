extends Node2D

export var itemname:String
onready var label = $label/label
onready var anim = $AnimationPlayer
onready var sprite = $sprite

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
