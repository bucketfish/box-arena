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
	reset()
	
func reset():
	backanim.play("RESET")
	anim.play("RESET")
	visible = false
	on = false
	curscreen = "none"
	
func turnon():
	visible = true
	backanim.play("pause")
	curscreen = "main"
	on = true
	
func turnoff():
	backanim.play("unpause")
	curscreen = "none"
	yield(anim, "animation_finished")
	on = false
	visible = false
	
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
		turnoff()
		
		

func _on_continue_pressed():
	if on:
		turnoff()

func _on_goto_screen(scenename):
	if curscreen != "none":
		anim.play_backwards(curscreen)
		yield(anim, "animation_finished")
	anim.play(scenename)
	curscreen = scenename


func _on_exit_pressed():
	base.save_and_quit()
