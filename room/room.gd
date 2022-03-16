extends Node2D

onready var base = get_node("/root/base")

export(Array, NodePath) var doors := []
onready var anim = $AnimationPlayer

const item = preload("res://items/item.tscn")

var roomtype = "loot"
var roomlevel = 0

func generateloot():
	var loot = ['wooden stick', 'healing drop', 'cookie', 'wooden sword', 'health pot', 'choco cookie', 'clothes', 'stone sword', 'leather padding', 'apple pie', 'stone axe', 'health potion', 'sharp flint', 'steak', 'iron armor']
	
	loot = Functions.generate_loot(Persistent.coords)
	
	# create the loot and instance it into scene
	for thing in loot:
		var curitem = item.instance()
		curitem.itemname = thing
		add_child(curitem)
		# randomly generate position of loot // sometime update this to like. reflect past positions of stuff?? or nah
		curitem.position.x = rand_range(412, 612)
		curitem.position.y = rand_range(200, 400)
	
	
func generateboss():
	pass
	
func _ready():
	#check if it's a boss room
	if abs(Persistent.coords.x) in Data.fightplaces or abs(Persistent.coords.y) in Data.fightplaces:
		roomtype = "boss"
	
	if roomtype == "loot":
		generateloot()
	elif roomtype == "boss":
		generateboss()
	else:
		pass
	
	

	
