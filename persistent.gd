extends Node

onready var player = get_node("/root/base/player")

var endgames = []

var coords = Vector2()
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
				'10 -10': {'name': 'poinkydirtie', 'alive': true},
				'10 10': {'name': 'swooshymooshy', 'alive': true},
				'-10 10': {'name': 'foofeefoofee', 'alive': true},
				'-10 -10': {'name': 'puffpuffiepuff', 'alive': true}}
var seenbosses = []

var carrying = ["wooden stick"] setget sort_inv

var health = 5
var energy = 10
var damage = 0
var max_health = 5
var defeated = false

var coward = 0
var isCoward = false

var weapon = "" setget set_weapon

func set_weapon(newval):
	weapon = newval
	player.update_weapon()
	

func items_custcomp(a, b):
	return Data.itemsorder.find( a ) < Data.itemsorder.find( b )

func sort_inv(newval):
	if !(weapon in newval) && weapon != "":
		set_weapon("")
		
	newval.sort_custom(self, "items_custcomp")
	carrying = newval
	
func _ready():
	sort_inv(carrying)
