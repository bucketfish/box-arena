extends "res://monsters/monster.gd"



func _ready():
	pass # hitbox.damage = damage

func take_damage(damageval):
	hurt(damageval)
