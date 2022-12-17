extends Control

onready var anim = $anim
onready var backanim = $backanim

onready var base = get_node("/root/base")
onready var fadeanim = $"../../anim"

var curscreen = "main"
var onscreen = true

func _ready():
	anim.play("RESET")
	start_show()

	
func start_show():
	get_tree().paused = true
	backanim.play("show")
	curscreen = "main"
	
	
func hide_menu():
	backanim.play("hide")
	get_tree().paused = false
	base.start_game()
	curscreen = "none"

func returnto(): #return to main menu, after saving
	start_show()


func _on_play_pressed():
	
	yield(base.start_game(), "completed")
	
	hide_menu()



func _on_goto_screen(scenename):
	if curscreen != "none":
		anim.play_backwards(curscreen)
		yield(anim, "animation_finished")
	anim.play(scenename)
	curscreen = scenename
	
	

func _input(event):
	if Input.is_action_just_pressed("pause") && curscreen != "main" && curscreen != "none":
		var nextscreen = "main"
		if curscreen == "controls" || curscreen == "audio":
			nextscreen = "options"
			
		anim.play_backwards(curscreen)
		yield(anim, "animation_finished")
		anim.play(nextscreen)
		curscreen = nextscreen


func _on_quit_pressed():
	quit_game()
	
func quit_game():
	fadeanim.play("fade")
	yield(fadeanim, "animation_finished")
	get_tree().quit()
