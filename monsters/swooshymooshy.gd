extends "res://monsters/monster.gd"


var spawn_scene = preload("res://monsters/swooshymooshy_spawn.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $timer

func _ready():
	timer.wait_time = rand_range(5, 10)
	timer.start()

func take_damage(damageval):
	hurt(damageval)

func spawn_child():
	var newc = spawn_scene.instance()
	newc.global_position = global_position
	base.curroom.add_child(newc)

func _on_timer_timeout():
	spawn_child()
	timer.wait_time = rand_range(2, 7)
	timer.start()
