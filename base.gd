extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $player
onready var anim = $anim

onready var coordslabel = $gui/coords
onready var inventory = $gui/inventory
onready var shade = $gui/shade
const room = preload("res://room/middle_room.tscn")

var curroom
var comefrom
var trans = false


func _ready():
	curroom = $room
	
func goto(dirfrom):
	trans = true
	# update new room coordinates
	if dirfrom == "up":
		Persistent.coords.y += 1
	elif dirfrom == "left":
		Persistent.coords.x -= 1
	elif dirfrom == "right":
		Persistent.coords.x += 1
	elif dirfrom == "down":
		Persistent.coords.y -= 1
	
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
	coordslabel.text = str(Persistent.coords.x) + " " + str(Persistent.coords.y)
	
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
	trans = false
	
func _input(event):
	if !trans && Input.is_action_just_pressed("inventory"):
		inventory.toggle()
		shade.visible = inventory.visible
		player.canmove = !inventory.visible
			
