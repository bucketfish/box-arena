extends Control


onready var max_health = $health/overlay
onready var health = $health/bar
onready var energy = $energy/bar

func _ready():
	update_bars()


func update_bars():
	max_health.rect_size.x = 2 * Persistent.max_health
	health.rect_size.x = 2 * Persistent.health
	energy.rect_size.x = 2 * Persistent.energy
