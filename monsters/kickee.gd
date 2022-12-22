extends "res://monsters/monster.gd"

onready var hitbox2 = $Sprite/hitbox

func _ready():
	hitbox2.damage = damage
	hitbox2.damage_source = type

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)
