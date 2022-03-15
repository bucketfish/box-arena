extends "res://monsters/monster.gd"

onready var anim = $animtree.get("parameters/playback")
onready var hurtanim = $damage_anim
onready var player_detect = $player_detect
onready var sprite = $Sprite
onready var hurtbox = $hurtbox
onready var hitbox2 = $hitbox2

var velocity = Vector2()
var knockback = Vector2()

export var speed = 130
export var friction = 0.4
export var acceleration = 0.4

var state = "idle"

func _ready():
	anim.travel("idle")
	hitbox2.damage = damage

func take_damage(damageval):
	hurtanim.play("hurt")
	knockback = player_detect.player.knockback_vector * 500
	hurt(damageval)
	hurtbox.start_invincibility(0.5)

		
func _physics_process(delta):
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	
	knockback = move_and_slide(knockback)
	
	match state:
		"idle":
			velocity = lerp(velocity, Vector2(), friction * delta * 100)

			seek_player()
			
		"chase":
			var player = player_detect.player
			if player != null && abs(global_position.distance_to(player.global_position)) > 60:
				var direction = (player.global_position - global_position).normalized()
				
				velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
				
			else:
				state = "idle"
			sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)

func seek_player():
	if player_detect.can_see_player():
		state = "chase"
		

func _on_damage_timeout():
	anim.travel("charge")
