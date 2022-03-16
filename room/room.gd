extends Node2D

onready var base = get_node("/root/base")

export(Array, NodePath) var doors := []
onready var anim = $AnimationPlayer

const item = preload("res://items/item.tscn")

var roomtype = "loot"
var roomlevel = 0

func generate_loot():
	var loot = Functions.generate_loot(Persistent.coords)
	
	spawn_loot(loot)
	
	
func generate_boss():
	var gen = Functions.generate_boss(Persistent.coords)
	
	spawn_loot(gen["contents"])
	
	if gen["boss"] != "":
		spawn_boss(gen["boss"])
		
func spawn_loot(listof):
	# create the loot and instance it into scene
	for thing in listof:
		var curitem = item.instance()
		curitem.itemname = thing
		add_child(curitem)

		curitem.position.x = rand_range(412, 612)
		curitem.position.y = rand_range(200, 400)
		
func spawn_boss(bossname):
	var curboss = Data.boss_scenes[bossname].instance()
	curboss.position = Vector2(512, 300)
	add_child(curboss)
	
func _ready():
	#check if it's a boss room
	if abs(Persistent.coords.x) in Data.fightplaces or abs(Persistent.coords.y) in Data.fightplaces:
		roomtype = "boss"
	
	if roomtype == "loot":
		generate_loot()
	elif roomtype == "boss":
		generate_boss()
	else:
		pass
	
	

	
