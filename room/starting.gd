extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $AnimationPlayer
onready var base = get_node("/root/base")
const item = preload("res://items/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Persistent.id_keep)
	Persistent.connect("endgame", self, "cutscene")
	$spin.visible = false
	if !Persistent.id_keep['outoffirstroom']:
		$up.visible = true
		$down.visible = true
		$left.visible = true
		$right.visible = true
		Persistent.id_keep['outoffirstroom'] = true

func cutscene():
	$fire.clear()
	$air.clear()
	$water.clear()
	$earth.clear()
	$spin.visible = true
	base.state = "cutscene"
	anim.play("end")
	
func spawn_blade():
	var curitem = item.instance()
	curitem.itemname = "elemental blade"
	add_child(curitem)
	curitem.position = Vector2(512, 300)
	Persistent.places[Persistent.coords].append("elemental blade")
	base.state = "play"

