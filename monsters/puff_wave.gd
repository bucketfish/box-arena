extends Node2D


onready var player = get_node("/root/base/player")
onready var hitbox = $hitbox
export var oripos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = get_parent().get_node("Sprite/Position2D").global_position
	throw_knife()


func throw_knife():
	var tween = $tween
	var playerpos = player.global_position
	var speed = 100
	oripos = global_position
	
	
	tween.interpolate_property(self, "global_position",
		oripos, playerpos, oripos.distance_to(playerpos) / speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	global_rotation = oripos.angle_to_point(playerpos)
	tween.start()
	yield(tween, "tween_completed")
	print("done")
	queue_free()
