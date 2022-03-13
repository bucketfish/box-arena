extends Area2D

onready var base = get_node("/root/base")

export var target = Vector2()

export(String) var doorpos


func _ready():
	target = base.curcoords
	
# when player enters the door area, go to the next room
func _on_door_body_entered(body):
	if body.is_in_group("player"):
		if body.canmove:
			base.goto(doorpos)
