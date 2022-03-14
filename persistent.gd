extends Node

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

var carrying = []
var health = 5
var energy = 5
var damage = 0
var total_health = 5
var defeated = false

var coward = 0
var isCoward = false
