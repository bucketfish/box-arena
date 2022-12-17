extends Node

onready var player = get_node("/root/base/player")
onready var base = get_node("/root/base")

var endgames = []

var coords = Vector2(-1, 0)
var places = {
			Vector2(0, 0) :[],
			Vector2(1, 0): ['cookie'],
			Vector2(1, 1): ['wooden stick'],
			Vector2(0, 1): ['cookie'],
			Vector2(0, -1): ['wooden stick'],
			Vector2(-1, -1): ['wooden stick'],
			Vector2(-1, 0): ['healing drop'],
			Vector2(-1, 1):['cookie'],
			Vector2(1, -1):['healing drop']}

var beenplaces  = [Vector2()]
var genbosses = {
				Vector2(10, -10): {'name': 'poinkydirtie', 'alive': true},
				Vector2(10, 10): {'name': 'swooshymooshy', 'alive': true},
				Vector2(-10, 10): {'name': 'foofeefoofee', 'alive': true},
				Vector2(-10, -10): {'name': 'puffpuffiepuff', 'alive': true}}
var seenbosses = []

var carrying = [] setget sort_inv

var health = 5 setget update_health
var energy = 5 setget update_energy
var damage = 0
var max_health = 5 setget update_maxhealth
var defeated = false

var coward = 0
var isCoward = false

var weapon = "" setget set_weapon

func update_health(newval):
	health = newval
	base.bars.update_bars()

func update_energy(newval):
	energy = newval
	base.bars.update_bars()
	
func update_maxhealth(newval):
	max_health = newval
	base.bars.update_bars()
	
func set_weapon(newval):
	weapon = newval
	player.update_weapon()
	base.update_weapon()

func items_custcomp(a, b):
	return Data.itemsorder.find( a ) < Data.itemsorder.find( b )

func sort_inv(newval):
	if !(weapon in newval) && weapon != "":
		set_weapon("")
		
	newval.sort_custom(self, "items_custcomp")
	carrying = newval
	
func _ready():
	sort_inv(carrying)



func save_game():
	#prepares the file
	var saves = File.new()
	saves.open("user://saves.save", File.WRITE)
	
	#vars to save
	var vals = {
		"endgames": endgames,
		"coords": coords,
		"places": places,
		"beenplaces": beenplaces,
		"genbosses": genbosses,
		"seenbosses": seenbosses,
		"carrying": carrying,
		"health": health,
		"energy": energy,
		"damage": damage,
		"max_health": max_health,
		"defeated": defeated,
		"coward": coward,
		"isCoward": isCoward,
		"weapon": weapon
	}

	saves.store_line(to_json(vals))
	
	print("game saved!")
	saves.close()
	#emit_signal("finish_save")
	

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://saves.save"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://saves.save", File.READ)

	# Get the saved dictionary from the next line in the save file
	var vals = parse_json(save_game.get_line())
	
	for i in vals.keys():
		print(i, vals[i])
		
		set(i, vals[i])

	save_game.close()
	print("loaded!")
	#emit_signal("finish_load")


	sort_inv(carrying)



# OH WAHT I ALREADY DID SAVING AND LOADING. OK I GUESS
