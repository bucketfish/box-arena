extends "res://monsters/monster.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

	velocity = Vector2(speed, 0)
	call_phyproc = false
	rng.randomize()
	rotation += rng.randf_range(-PI / 4, PI / 4)
#
#func _physics_process(delta):
#
#
#	knockback = lerp(knockback, Vector2(), friction * delta * 10)
#
#	knockback = move_and_slide(knockback)
#
#	velocity = lerp(velocity, velocity + get_slide_collision(0).normal * speed, acceleration * delta * 100 )
#


func _physics_process(delta):
	if !base.state in ["play", "inv"] || base.boss_move == false:
		return
	
	rotation = velocity.angle()
		
	knockback = lerp(knockback, Vector2(), friction * delta * 10)
	knockback = move_and_slide(knockback)
	
#	velocity = speed lerp(velocity, Vector2(speed, 0), acceleration * delta * 100)
		
	var collision = move_and_collide(velocity * delta) 
	
	if collision:
		handle_collision(collision)

func handle_collision(collision : KinematicCollision2D):
	velocity = velocity.bounce(collision.normal)
	

func take_damage(damageval):
	hurt(damageval)

#
#	if abs(global_position.distance_to(player.global_position)) > 40:
#		var direction = (player.global_position - global_position).normalized()
#
#		velocity = lerp(velocity, direction * speed, acceleration * delta * 100)
#
#	else:
#		velocity = lerp(velocity, Vector2(), friction * delta * 100)
#
#	sprite.flip_h = velocity.x < 0
#
#	velocity = move_and_slide(velocity)
