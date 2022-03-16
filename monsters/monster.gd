extends KinematicBody2D


var health
var damage
var invincible = false
export var type = "nyam"
const item = preload("res://items/item.tscn")
onready var base = get_node("/root/base")
onready var player = get_node("/root/base/player")


onready var hitbox = $hitbox
onready var player_detect = $player_detect
onready var sprite = $Sprite
onready var hurtanim = $damage_anim
onready var hurtbox = $hurtbox

var velocity = Vector2()
var knockback = Vector2()

export var speed = 130
export var knockback_val = 500
var friction = 0.4
var acceleration = 0.4



var state = "idle"

func _ready():
	health = Data.bosses[type]["health"]
	damage = Data.bosses[type]["damage"]
	speed = Data.bosses[type]['speed']
	knockback_val = Data.bosses[type]['knockback']
	
	hitbox.damage = damage
	
func hurt(damageval):
	knockback = player.knockback_vector * knockback_val
	hurtanim.play("hurt")
	hurtbox.start_invincibility(0.8)
	
	health -= damageval
	if health <= 0:
		die()
	

func die():
	for i in Data.bosses[type]["drop"]:
		var curitem = item.instance()
		curitem.itemname = i
		curitem.global_position = global_position + Vector2(rand_range(-40, 40), rand_range(-40, 40))
		base.curroom.call_deferred("add_child", curitem)
		
		Persistent.places[Persistent.coords].append(i)
		
	queue_free()



func _physics_process(delta):
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	
	knockback = move_and_slide(knockback)
	
	if abs(global_position.distance_to(player.global_position)) > 40:
		var direction = (player.global_position - global_position).normalized()
				
		velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
				
	else:
		velocity = lerp(velocity, Vector2(), friction * delta * 100)
		
	sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)

func seek_player():
	if player_detect.can_see_player():
		state = "chase"
