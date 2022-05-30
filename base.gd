extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $player
onready var anim = $anim

onready var coordslabel = $gui/bars/coords
onready var inventory = $gui/inventory
onready var bossui = $gui/boss
onready var shade = $gui/shade
onready var bosspause_timer = $bosspause_timer
const room = preload("res://room/room.tscn")

onready var pause = $gui/pause

var curroom
var comefrom
var trans = false setget update_trans

var state = "play" setget update_state

var boss_move = true
# states: play, inv, pause


func _ready():
	curroom = $room
	
func goto(dirfrom):
	update_trans(true)
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
	
	#deactivate prev room stuff
	bossui.animon = false
	
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
	update_trans(false)
	if curroom.roomtype == "boss" && Persistent.genbosses[Persistent.coords]["alive"] == true:
		boss_room(Persistent.genbosses[Persistent.coords]['name'])
	
func _input(event):
	if !trans && Input.is_action_just_pressed("inventory"):
		inventory.toggle()
		shade.visible = inventory.visible
		if inventory.visible:
			update_state("inv")
		else:
			update_state('play')
			
	if Input.is_action_just_pressed("pause"):
		pause.toggle()
#		if inventory.visible:
#			update_state("inv")
#		else:
#			update_state('play')
			
			
func update_state(newstate):
	if newstate == "play":
		player.canmove = true
	else:
		player.canmove = false
	state = newstate
	
func update_trans(newval):
	if newval:
		player.canmove = false
		update_state("pause")
	else:
		player.canmove = true
		update_state("play")
		boss_move = false
		bosspause_timer.start()
		
		
	trans = newval

func boss_room(boss):
	bossui.set_boss(boss)

func _on_bosspause_timer_timeout():
	boss_move = true
