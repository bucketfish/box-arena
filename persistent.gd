extends Node

onready var player = get_node("/root/base/player")
onready var base = get_node("/root/base")

var firstload = true
var endgames = []

var damagesource = ""
var id_keep = {
	"firekey": false,
	"airkey": false,
	"waterkey": false,
	"earthkey": false,
	'outoffirstroom': false 
} setget update_keeps
var carrying = ["elemental blade", "fire key", "earth key", "water key", "air key", "fishcow"] setget sort_inv

signal endgame
var coords = Vector2(0, 0)
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



var health = 5 setget update_health
var energy = 5 setget update_energy
var damage = 0
var max_health = 5 setget update_maxhealth
var defeated = false

var coward = 0
var isCoward = false

var weapon = "" setget set_weapon

# WHEN ADDING A NEW VARIABLE:
# 1. create variable
# 2. allow it to be reset. if needed
# 3. allow it to be saved
# 4. allow it to be loaded
func reset():
		
	endgames = []
	id_keep = {
		"firekey": false,
		"airkey": false,
		"waterkey": false,
		"earthkey": false,
		'outoffirstroom': false
	}
	carrying = []
	coords = Vector2(0, 0)
	places = {
				Vector2(0, 0) :[],
				Vector2(1, 0): ['cookie'],
				Vector2(1, 1): ['wooden stick'],
				Vector2(0, 1): ['cookie'],
				Vector2(0, -1): ['wooden stick'],
				Vector2(-1, -1): ['wooden stick'],
				Vector2(-1, 0): ['healing drop'],
				Vector2(-1, 1):['cookie'],
				Vector2(1, -1):['healing drop']}

	beenplaces  = [Vector2()]
	genbosses = {
					Vector2(10, -10): {'name': 'poinkydirtie', 'alive': true},
					Vector2(10, 10): {'name': 'swooshymooshy', 'alive': true},
					Vector2(-10, 10): {'name': 'foofeefoofee', 'alive': true},
					Vector2(-10, -10): {'name': 'puffpuffiepuff', 'alive': true}}
	seenbosses = []

	health = 5 
	energy = 5 
	damage = 0
	max_health = 5 
	defeated = false
	weapon = ""
	damagesource = ""
	
	save_game()
	
	

func update_health(newval):
	health = newval
	base.bars.update_bars()
	
	if health <= 0:
		base.die(damagesource)

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


func update_keeps(new_keep):
	id_keep = new_keep
	
	if id_keep["firekey"] && id_keep["airkey"] && id_keep["waterkey"]  && id_keep["earthkey"] && !defeated:
		defeated = true
		emit_signal("endgame")


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
		"weapon": weapon,
		'id_keep': id_keep,
		'firstload': firstload,
	}

	saves.store_line(to_json(vals))
	
	print("game saved!")
	saves.close()
	#emit_signal("finish_save")
	

func load_game():
	var veckeys = ["genbosses", "places"]
	var vecarr = ["beenplaces"]
	var vecsingle = ["coords"]
	
	
	var save_game = File.new()
	if not save_game.file_exists("user://saves.save"):
		yield(get_tree(), "idle_frame")
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://saves.save", File.READ)

	# Get the saved dictionary from the next line in the save file
	var vals = parse_json(save_game.get_line())
	
	for i in vals.keys():
		if i in veckeys:
			set(i, {})
			for key in vals[i].keys():
				get(i)[str2var("Vector2" + key)] = vals[i][key]
			
		elif i in vecarr:
			set(i, [])
			for item in vals[i]:
				get(i).append(str2var("Vector2" + item))
				
		elif i in vecsingle:
			set(i, str2var("Vector2" + vals[i]))
		
			
		else:
			set(i, vals[i])

	save_game.close()
	print("loaded!")
	#emit_signal("finish_load")
	sort_inv(carrying)
	yield(get_tree(), "idle_frame")



# OH WAHT I ALREADY DID SAVING AND LOADING. OK I GUESS
