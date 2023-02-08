extends Control

onready var anim = $anim
onready var backanim = $backanim
onready var saves = $saves

onready var base = get_node("/root/base")
onready var fadeanim = $"../../anim"

var curscreen = "main"
var onscreen = true

func _ready():
	
	visible = true
	anim.play("RESET")
	start_show()

	
func start_show():

	get_tree().paused = true
	backanim.play("show")
	curscreen = "main"
	
	
func hide_menu():
	backanim.play("hide")
	get_tree().paused = false
	curscreen = "none"

func returnto(): #return to main menu, after saving
	base.update_pause(true)
	base.update_state("paused")
	start_show()


func save_selected(save_num):
	Persistent.savenum = save_num
	saves.play_label.visible = false
	yield(base.start_game(), "completed")
	hide_menu()



func _on_goto_screen(scenename):
	var oldscreen = curscreen
	curscreen = scenename
	
	if scenename == "saves":
		saves.prepare_saves()
		backanim.play("hide_title")
		saves.play_label.visible = false
	
	if oldscreen == "saves":
		saves.play_label.visible = false
		
	if oldscreen != "none":
		anim.play_backwards(oldscreen)
		yield(anim, "animation_finished")
		
	if oldscreen == "saves":
		backanim.play_backwards('hide_title')
		saves.prepare_saves()
		
	anim.play(scenename)
		
#	curscreen = scenename
	
	

func _input(event):
	if Input.is_action_just_pressed("pause") && curscreen != "main" && curscreen != "none":
		var nextscreen = "main"
		if curscreen == "controls" || curscreen == "audio":
			nextscreen = "options"
		
		_on_goto_screen(nextscreen)


func _on_quit_pressed():
	quit_game()
	
func quit_game():
	var audio_tween = $"../../audio_tween"
	var ost = $"../../ost"

	audio_tween.interpolate_property(ost, "volume_db", 0, -60, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	audio_tween.start()

	fadeanim.play("fade")
	yield(fadeanim, "animation_finished")
	yield(audio_tween, "tween_completed")
#	yield(base.audio_fadeout(), "completed")
	get_tree().quit()



