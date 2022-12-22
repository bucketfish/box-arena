extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var causetext = $VBoxContainer/cause
onready var mocktext = $VBoxContainer/mock
onready var restart = $restart
onready var base = get_node("/root/base")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func reset_item():
	visible = false
	
func death(cause):
	if cause in Data.bosses:
		causetext.text = Data.bosses[cause]["death"][rand_range(0, Data.bosses[cause]["death"].size() - 1)]
		visible = true
		restart.grab_focus()
		
	mocktext.text = Data.deathliners[rand_range(0, Data.deathliners.size() - 1)]
	


func _on_restart_pressed():
	Persistent.reset()
	base.start_game()


func _on_main_menu_pressed():
	Persistent.reset()
	base.save_and_quit(false)
