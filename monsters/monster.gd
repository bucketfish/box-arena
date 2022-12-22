extends KinematicBody2D


var health
var damage
export var type = "nyam"
export var width = 0.4
const item = preload("res://items/item.tscn")
onready var base = get_node("/root/base")
onready var player = get_node("/root/base/player")

var call_phyproc = true
var fliph = true

onready var hitbox = $hitbox
onready var sprite = $Sprite
onready var hurtanim = $damage_anim
onready var hurtbox = $hurtbox

var velocity = Vector2()
var knockback = Vector2()

export var speed = 130
export var knockback_val = 500
var friction = 0.4
var acceleration = 0.3



var state = "idle"

func _ready():
	health = Data.bosses[type]["health"]
	damage = Data.bosses[type]["damage"]
	speed = Data.bosses[type]['speed']
	knockback_val = Data.bosses[type]['knockback']
	
	hitbox.damage = damage
	hitbox.damage_source = type
	
	
func call_pause(ispaused):
	print(ispaused)
	
	if ispaused:
		$anim.stop(false)
	else:
		$anim.play()
		
func hurt(damageval):
	knockback = player.knockback_vector * knockback_val
	hurtanim.play("hurt")
	hurtbox.start_invincibility(0.6)
	
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
		
	Persistent.genbosses[Persistent.coords]['alive'] = false
	
	queue_free()

func _physics_process(delta):
	if !call_phyproc:
		return
		
	if !base.state in ["play", "inv"] || base.boss_move == false:
		return
	
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	
	knockback = move_and_slide(knockback)
	
	if abs(global_position.distance_to(player.global_position)) > 40:
		var direction = (player.global_position - global_position).normalized()
				
		velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
				
	else:
		velocity = lerp(velocity, Vector2(), friction * delta * 100)
		
	if fliph:
		if velocity.x < 0:
			sprite.scale.x = -width
		else:
			sprite.scale.x = width
			
	velocity = move_and_slide(velocity)

