extends "res://monsters/monster.gd"

onready var hitbox2 = $Sprite/hitbox

func _ready():
	hitbox2.damage = damage

func take_damage(damageval):
	hurt(damageval)
