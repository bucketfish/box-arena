extends "res://monsters/monster.gd"

onready var anim = $anim

onready var spawnpos = $Sprite/Position2D

var puff_wave = preload("res://monsters/puff_wave.tscn")

func _ready():
	pass # hitbox.damage = damage

func take_damage(damageval):
	hurt(damageval)

func throw_knife():
	
	var new = puff_wave.instance()
	new.oripos = $Sprite/Position2D.global_position
	add_child(new)
	
	
