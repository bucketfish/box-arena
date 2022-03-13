extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $player
onready var anim = $anim
const room = preload("res://room/middle_room.tscn")

var curcoords = Vector2()
var curroom
var comefrom

func _ready():
	curroom = $room
	
func goto(dirfrom):
	# update new room coordinates
	if dirfrom == "up":
		curcoords.y += 1
	elif dirfrom == "left":
		curcoords.x -= 1
	elif dirfrom == "right":
		curcoords.x += 1
	elif dirfrom == "down":
		curcoords.y -= 1
	
	comefrom = dirfrom
	
	#save current room // todo!
	
	player.canmove = false
	
	# run "fade-out" animation
	if dirfrom == "up":
		anim.play("fromup")
		curroom.anim.play("fromup")
	elif dirfrom == "left":
		anim.play("fromleft")
		curroom.anim.play("fromleft")
	elif dirfrom == "right":
		anim.play("fromright")
		curroom.anim.play("fromright")
	else:
		anim.play("fromdown")
		curroom.anim.play("fromdown")
	
	yield(anim, "animation_finished")
	curroom.queue_free()
	
	# update coordinates tag
	$CanvasLayer/coords.text = str(curcoords.x) + " " + str(curcoords.y)
	
	# update player position (new door)
	player.position = get_node(dirfrom).position
	
	curroom = room.instance()
	add_child(curroom)
	
	# "fade-in" transition
	if dirfrom == "up":
		anim.play_backwards("fromdown")
		curroom.anim.play_backwards("fromdown")
	elif dirfrom == "left":
		anim.play_backwards("fromright")
		curroom.anim.play_backwards("fromright")
	elif dirfrom == "right":
		anim.play_backwards("fromleft")
		curroom.anim.play_backwards("fromleft")
	else:
		anim.play_backwards("fromup")
		curroom.anim.play_backwards("fromup")
	
	yield(anim, "animation_finished")
	
	# continue the game
	player.canmove = true
	
