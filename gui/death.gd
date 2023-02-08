extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var causetext = $VBoxContainer/cause
onready var timertext = $VBoxContainer/timer
onready var restart = $restart
onready var base = get_node("/root/base")
onready var deathsound = $death
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func reset_item():
	visible = false
	
func death(cause):
	deathsound.play()
	if cause in Data.bosses:
		causetext.text = Data.bosses[cause]["death"][randi() % Data.bosses[cause]["death"].size()]
		
	elif cause == "fishcow":
		causetext.text = Data.fishcow_death[randi() % Data.fishcow_death.size()]
		
	visible = true

	timertext.text = "you survived for " + Functions.make_time(Persistent.timer) + "."
	
	yield(get_tree().create_timer(0.1), "timeout")
	restart.grab_focus()
	
	Persistent.delete_save(Persistent.savenum)
	


func _on_restart_pressed():
	base.anim.play("fade")
	yield(base.anim, "animation_finished")
	Persistent.reset()
	base.curroom.queue_free()
	yield(base.start_game(), "completed")
	base.anim.play_backwards("fade")
#	yield(base.anim, "animation_finished")


func _on_main_menu_pressed():
#	Persistent.reset()
	base.save_and_quit(false)
