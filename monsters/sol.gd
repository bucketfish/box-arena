extends "res://monsters/monster.gd"

onready var anim = $animtree.get("parameters/playback")
onready var player_detect = $player_detect
onready var sprite = $Sprite

var velocity = Vector2()
var knockback = Vector2()

export var speed = 170
export var friction = 0.4
export var acceleration = 0.4

var state = "idle"

func _ready():
	anim.travel("idle")

func take_damage():
	if !invincible:
		invincible = true
		knockback = player_detect.player.knockback_vector * 500
		hurt()
		yield(get_tree().create_timer(1), "timeout")
		invincible = false

		
func _physics_process(delta):
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	
	knockback = move_and_slide(knockback)
	
	match state:
		"idle":
			velocity = lerp(velocity, Vector2(), friction * delta * 100)

			seek_player()
			
		"chase":
			var player = player_detect.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				
				velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
				
			else:
				state = "idle"
			sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)

func seek_player():
	if player_detect.can_see_player():
		state = "chase"
	
