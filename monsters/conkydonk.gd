extends "res://monsters/monster.gd"



func _ready():
	pass

func take_damage(damageval):
	hurt(damageval)
	
func call_pause(ispaused):
	if ispaused:
		$AnimationPlayer.stop(false)
	else:
		$AnimationPlayer.play()
