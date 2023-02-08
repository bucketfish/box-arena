extends Area2D


onready var base = get_node("/root/base")
onready var display = $display
onready var anim = $AnimationPlayer
onready var audio = $audio

var in_range = false
var has_item = false

export var hint_text:String
export var object:String
export var id:String


# Called when the node enters the scene tree for the first time.
func _ready():
	prepare()


func prepare():
	if Persistent.id_keep[id] && !Persistent.defeated:
		display.texture = load("res://assets/items/" + object + ".png")
		
		anim.play("bounce")
		anim.advance(rand_range(0, 1.4))
	else:
		display.texture = null


func _on_interact_body_entered(body):
	if body.is_in_group("player") && !Persistent.id_keep[id] && object in Persistent.carrying:
		base.canuse[hint_text] = true
		in_range = true


func _on_interact_body_exited(body):
	if body.is_in_group("player") && in_range == true:
		base.canuse[hint_text] = false
		in_range = false
		
		
func _input(event):
	if Input.is_action_just_pressed("take") && in_range && !Persistent.id_keep[id] && object in Persistent.carrying:
		audio.play()
		
		Persistent.id_keep[id] = true
		Persistent.carrying.erase(object)
		Persistent.sort_inv(Persistent.carrying)
		
		if !Persistent.defeated:
			display.texture = load("res://assets/items/" + object + ".png")
			anim.play("bounce")
		

	
func clear():
	display.texture = null
			
		
			


