extends KinematicBody2D


var health
var damage
export var type = "nyam"
export var width = 0.4
const item = preload("res://items/item.tscn")
onready var base = get_node("/root/base")
onready var player = get_node("/root/base/player")
onready var hurt_particle = $Particles2D

var call_phyproc = true
var fliph = true

onready var hitbox = $hitbox
onready var sprite = $Sprite
onready var hurtanim = $damage_anim
onready var hurtbox = $hurtbox

var dropsound = preload("res://audio/sfx/monsters/boss_drop.wav")

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
	
	if ispaused:
		$anim.stop(false)
	else:
		$anim.play()
		
func hurt(damageval):
	var damage_tween = $damage_tween

	knockback = player.knockback_vector * knockback_val
	hurt_particle.rotation = knockback.angle()
	
	
	hurtanim.play("hurt")
	hurtbox.start_invincibility(0.6)
	base.freeze_engine(0.2)
	
	health -= damageval
	
	base.bossui.boss_health(health, Data.bosses[type]["health"])
	
	if health <= 0:
		die()
	

func die():
	
	var drop_sound = AudioStreamPlayer2D.new()
	drop_sound.bus = "SFX"
	drop_sound.stream = dropsound
	drop_sound.global_position = self.global_position
	base.add_child(drop_sound)
	drop_sound.play()
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

