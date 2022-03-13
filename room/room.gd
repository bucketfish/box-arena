extends Node2D

onready var base = get_node("/root/base")

export(Array, NodePath) var doors := []
onready var anim = $AnimationPlayer

const item = preload("res://items/item.tscn")

var roomtype = "loot"
var roomlevel = 0

func generateloot():
	var loot = ["cookie", "wooden stick", "healing drop", "wooden sword"]
	
	# create the loot and instance it into scene
	for thing in loot:
		var curitem = item.instance()
		curitem.itemname = thing
		add_child(curitem)
		# randomly generate position of loot // sometime update this to like. reflect past positions of stuff?? or nah
		curitem.position.x = rand_range(412, 612)
		curitem.position.y = rand_range(200, 400)
	
func _ready():
	#check if it's a boss room
	if abs(base.curcoords.x) in Data.fightplaces or abs(base.curcoords.y) in Data.fightplaces:
		roomtype = "boss"
	
	if roomtype == "loot":
		generateloot()
	elif roomtype == "boss":
		pass
	else:
		pass
	
	

	
