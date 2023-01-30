extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $AnimationPlayer
onready var tween = $Tween
onready var sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func low_health():
	anim.get_animation("pulse").loop = true
	anim.play("pulse")
	
func return_to_normal():
	anim.get_animation("pulse").loop = false

