extends "res://monsters/monster.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)
