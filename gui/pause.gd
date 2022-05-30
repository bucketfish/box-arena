extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $anim
onready var contbutton = $play

var on = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("RESET")
	


func toggle():
	on = !on
	if on:
		anim.play("pause")
	else:
		anim.play_backwards("pause")
		
	yield(anim, "animation_finished")
	


func _on_continue_pressed():
	if on:
		anim.play_backwards("pause")
		on = false
