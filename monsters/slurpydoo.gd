extends "res://monsters/monster.gd"


func _ready():
	pass

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)
	
