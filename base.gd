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
onready var bars = $gui/bars
const room = preload("res://room/room.tscn")

onready var pause = $gui/pause
onready var mainmenu = $gui/mainmenu

onready var keyhints = $gui/keyhints
onready var minimap = $gui/minimap

var curroom
var comefrom
var trans = false setget update_trans

var state = "play" setget update_state
var paused = false setget update_pause

var boss_move = true

var canuse = {
	"use": false,
	"fuse": false,
	"take": false,
	"attack": false,
	"inventory": true
}
# states: play, inv, pause



func _ready():
	# DEBUG
	OS.set_current_screen(0)
	
	
	
	print(Data.bosses.keys().size())
	curroom = $room
	update_pause(true)
	update_state("paused")
	
	
func start_game():
	update_pause(false)
	update_state("play")
	propagate_call("reset_item")
	
func save_and_quit():
	update_pause(true)
	update_state("paused")
	mainmenu.returnto()
	
	
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
	
	#update minimap
	minimap.update_minimap()
	
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
	if !trans && !paused && Input.is_action_just_pressed("inventory"):
		inventory.toggle()
		shade.visible = inventory.visible
		if inventory.visible:
			update_state("inv")
		else:
			update_state('play')
			
	if Input.is_action_just_pressed("pause") && !pause.on:
		pause.turnon()
		update_pause(pause.on)
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
	
func update_weapon():
	if Persistent.weapon:
		canuse["attack"] = true
	else:
		canuse["attack"] = false
	keyhints.update_keyhints()

func update_pickup(can): #whether player is able to pick up anything
	canuse["take"] = can
	keyhints.update_keyhints()
	
var bossmove_prev = true
func update_pause(newpause):
	if newpause == false:
		player.canmove = true
		
		if bossmove_prev:
			boss_move = true
		bosspause_timer.paused = false
			
	else: #is paused
		player.canmove = false
		bossmove_prev = boss_move
		bosspause_timer.paused = true
		boss_move = false

	paused = newpause
	
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


func _on_goto_screen(name):
	pass # Replace with function body.
	# WHAT IS THIS>
