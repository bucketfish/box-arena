extends Control


onready var health = $health/value
onready var energy = $energy/value

func _ready():
	update_bars()


func update_bars():
	health.text = str(Persistent.health) + '/' + str(Persistent.max_health)
	energy.text = str(Persistent.energy)

