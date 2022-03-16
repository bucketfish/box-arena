extends "res://monsters/monster.gd"

onready var anim = $animtree.get("parameters/playback")

onready var hitbox2 = $hitbox2

func _ready():
	anim.travel("idle")
	hitbox2.damage = damage

func take_damage(damageval):
	hurt(damageval)
	
func _on_damage_timeout():
	anim.travel("charge")
