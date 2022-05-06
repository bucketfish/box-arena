extends Node2D

onready var base = get_node("/root/base")

export(Array, NodePath) var doors := []
onready var anim = $AnimationPlayer

const roomsize = 2

const item = preload("res://items/item.tscn")
const layouts = {
	"middle": preload("res://room/layouts/middle.tscn"),
	"up": preload("res://room/layouts/up.tscn"),
	"down": preload("res://room/layouts/down.tscn"),
	"left": preload("res://room/layouts/left.tscn"),
	"right": preload("res://room/layouts/right.tscn"),
	"leftup": preload("res://room/layouts/leftup.tscn"),
	"rightup": preload("res://room/layouts/rightup.tscn"),
	"leftdown": preload("res://room/layouts/leftdown.tscn"),
	"rightdown": preload("res://room/layouts/rightdown.tscn")
	
}

var roomtype = "loot"
var roomlevel = 0

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
	var layout = ""
	if Persistent.coords.x == -roomsize:
		layout += "left"
	if Persistent.coords.x == roomsize:
		layout += "right"
	if Persistent.coords.y == -roomsize:
		layout += "down"
	if Persistent.coords.y == roomsize:
		layout += "up"
	if layout == "":
		layout = "middle"
	
	add_child(layouts[layout].instance())
		

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
	

	
	

	
