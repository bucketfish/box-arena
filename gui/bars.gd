extends Control


onready var health = $health/value
onready var energy = $energy/value
onready var anim = $energy/anim

var col_pos_top = "#d7ebba"
var col_pos_back = "#7ead73"

func _ready():
	update_bars()


func update_bars():
	health.text = str(Persistent.health) + '/' + str(Persistent.max_health)
	energy.text = str(Persistent.energy)
	
	

func no_energy():
	anim.play("no_energy")
