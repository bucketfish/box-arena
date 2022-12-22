extends "res://monsters/monster.gd"

onready var hitbox2 = $Sprite2/hitbox

func _ready():
	pass

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)
