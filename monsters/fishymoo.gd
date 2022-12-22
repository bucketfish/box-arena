extends "res://monsters/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	fliph = false

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)
	
func _physics_process(delta):
	rotation = velocity.angle()
