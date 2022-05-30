extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $anim
onready var backanim = $backanim
onready var contbutton = $main/continue

onready var base = get_node("/root/base")

var curscreen = "none"

var on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	backanim.play("RESET")
	


func toggle():
	on = !on
	if on:
		backanim.play("pause")
		curscreen = "main"
	
	
func _input(event):
	if Input.is_action_just_pressed("pause") && curscreen != "main" && curscreen != "none":
		var nextscreen = ""
		if curscreen == "controls" || curscreen == "audio":
			nextscreen = "options"
		elif curscreen == "options":
			nextscreen = "main"
			
		anim.play_backwards(curscreen)
		yield(anim, "animation_finished")
		anim.play(nextscreen)
		curscreen = nextscreen
	
	elif Input.is_action_just_pressed("pause") && curscreen == "main":
		backanim.play("unpause")
		curscreen = "none"
		yield(anim, "animation_finished")
		on = false
		

func _on_continue_pressed():
	if on:
		backanim.play("unpause")
		on = false
		curscreen = "none"

	

func _on_goto_screen(scenename):
	anim.play_backwards(curscreen)
	yield(anim, "animation_finished")
	anim.play(scenename)
	curscreen = scenename
