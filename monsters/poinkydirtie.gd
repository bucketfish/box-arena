extends "res://monsters/monster.gd"

var has_knife = true

onready var anim = $anim
onready var knife = $knife_throw
onready var hitbox2 = $hitbox2
onready var hitboxknife = $knife_throw/knife_throw/hitbox
onready var hitbox3 = $Knife/hitbox

func _ready():
	call_phyproc = false
	hitbox2.damage = damage
	hitboxknife.damage = damage
	hitbox3.damage = damage

func take_damage(damageval, damagesource = "player"):
	hurt(damageval)

func _physics_process(delta):
	if !base.state in ["play", "inv"] || base.boss_move == false:
		return
	
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	
	knockback = move_and_slide(knockback)
	
	if abs(global_position.distance_to(player.global_position)) > 400 && has_knife:
		throw_knife()
		
	elif abs(global_position.distance_to(player.global_position)) > 40 && has_knife:
		var direction = (player.global_position - global_position).normalized()
				
		velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
		anim.play("spin")
		
	elif abs(global_position.distance_to(player.global_position)) > 40 :
		var direction = (player.global_position - global_position).normalized()
				
		velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
				
	else:
		velocity = lerp(velocity, Vector2(), friction * delta * 100)
		
#	if fliph:
#		sprite.flip_h = velocity.x < 0
#
	velocity = move_and_slide(velocity)

func throw_knife():
	anim.play("throw")
	var tween = $tween
	var playerpos = player.global_position
	var speed = 500
	has_knife = false
	
	tween.interpolate_property(knife, "global_position",
		knife.global_position, playerpos, knife.global_position.distance_to(playerpos) / speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	knife.global_rotation = knife.global_position.angle_to_point(playerpos)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(knife, "global_position",
		knife.global_position, global_position, knife.global_position.distance_to(global_position) / speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	knife.global_rotation = knife.global_position.angle_to_point(global_position)
	tween.start()
	yield(tween, "tween_completed")
	has_knife = true
	anim.play("spin")
