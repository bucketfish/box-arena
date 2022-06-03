extends Control

onready var anim = $anim
onready var backanim = $backanim

onready var base = get_node("/root/base")

func _ready():
	start_show()

	
func start_show():
	get_tree().paused = true
	backanim.play("show")
	
	
func hide_menu():
	backanim.play("hide")
	get_tree().paused = false
	base.start_game()

func returnto(): #return to main menu, after saving
	start_show()


func _on_play_pressed():
	hide_menu()
	base.start_game()

