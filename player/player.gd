extends KinematicBody2D

var velocity = Vector2()
var knockback_vector = Vector2()

export var speed = 300
export var friction = 0.4
export var acceleration = 0.6
export var canmove = true

onready var animtree = $animtree
onready var anim = $animtree.get("parameters/playback")
onready var hurtanim = $damageanim
onready var sprite = $Sprite
onready var pickup_area = $pickup_area
onready var weapon = $Sprite/weapon

onready var hitbox = $hitbox
onready var hurtbox = $hurtbox

onready var base = get_node("/root/base")
onready var bars = get_node("/root/base/gui/bars")

var fx_swing = preload("res://effects/swinganim.tscn")

var facing = "left"
var state = "idle"

func _ready():
	# set up and prep animations
	state = "idle"
	animtree.active = true

func get_input():
	# get input vector (to normalize)
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func move(direction, delta):
	if !canmove: # make it not move if the player isn't supposed to
		velocity = Vector2()
	
	# if the player is moving
	elif direction.length() > 0:
		knockback_vector = direction
		velocity = lerp(velocity, direction.normalized() * speed, acceleration * delta * 100)
		state = "walk"
		
		# horizontal flips
		if direction.x > 0:
			sprite.scale.x = -abs(sprite.scale.x)
			hitbox.scale.x = -abs(hitbox.scale.x)
		elif direction.x < 0:
			sprite.scale.x = abs(sprite.scale.x)
			hitbox.scale.x = abs(hitbox.scale.x)
			
	# if the player is not moving, slowing down & friction
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta * 100)
		state = "idle"
	
	# attack animation
	if Input.is_action_just_pressed('attack') && canmove && Persistent.weapon && Persistent.energy >= abs(Data.items[Persistent.weapon]["energy"]):
		state = "attack"
		
	elif Input.is_action_just_pressed('attack') && canmove && Persistent.weapon && Persistent.energy < abs(Data.items[Persistent.weapon]["energy"]) && Persistent.energy > 0:
		bars.no_energy()

		
	anim.travel(state)
	velocity = move_and_slide(velocity)


func check_items():
	# check items around to show animation
	if pickup_area.get_overlapping_areas().size() > 0:
		base.update_pickup(true)
		var cl_area:Node2D # closest area
		var cl_dist = INF
		
		for i in pickup_area.get_overlapping_areas():
			var cur = i.get_parent()
			if cur.is_in_group("item"):
				# check if item is closer than previous closest item
				if cur.global_position.distance_to(global_position) < cl_dist:
					if cl_area:
						cl_area.isitem = false
					cl_dist = cur.global_position.distance_to(global_position)
					cl_area = cur
				else:
					cur.isitem = false
		
		# set whether that item should be activated
		cl_area.isitem = true
	else:
		base.update_pickup(false)
	
	
func _physics_process(delta):
	var direction = get_input()
	move(direction, delta)
	
	check_items()
	
	
func swing():
	hitbox.monitorable = true
	if Persistent.weapon != "":
		
		# spawn the swing effect
		var fx = fx_swing.instance()
		fx.swingdir = 1 if sprite.scale.x > 0 else -1
		
		if Input.is_action_pressed("up"):
			fx.dir = "up"
			hitbox.rotation_degrees = 90 * fx.swingdir
		elif Input.is_action_pressed("down"):
			fx.dir = "down"
			hitbox.rotation_degrees = -90 * fx.swingdir
		else:
			fx.dir = "none"
			hitbox.rotation_degrees = 0
			
		fx.global_position = global_position
		get_parent().add_child(fx)
		
		# deduct energy
		Persistent.energy += Data.items[Persistent.weapon]["energy"]
#		bars.update_bars()

		
			
func update_weapon():
	if Persistent.weapon != "":
		weapon.texture = load("res://assets/items/" + Persistent.weapon + ".png")
		hitbox.damage = Data.items[Persistent.weapon]["damage"]
	else:
		weapon.texture = null
		hitbox.damage = 0

func take_damage(damageval):
	hurtanim.play("hurt")
	Persistent.health -= damageval
#	bars.update_bars()
	hurtbox.start_invincibility(0.8)

