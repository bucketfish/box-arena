extends Node2D


var dir = "left"
var swingsize = 0.3
var swingdir = 1

onready var sprite = $swing
onready var anim = $anim
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.scale.x = swingsize * swingdir
	sprite.scale.y = swingsize
	if dir == "up":
		sprite.rotation_degrees = 90 * swingdir
	elif dir == "down":
		sprite.rotation_degrees = 90 * swingdir
		sprite.scale.x = -sprite.scale.x
	else:
		sprite.rotation_degrees = 0
	anim.play("swing")
	yield(anim, "animation_finished")
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
