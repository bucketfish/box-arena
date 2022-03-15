extends KinematicBody2D

var velocity = Vector2()
export var speed = 300
export var friction = 0.4
export var acceleration = 0.6
export var canmove = true

onready var animtree = $animtree
onready var anim = $animtree.get("parameters/playback")
onready var sprite = $Sprite
onready var pickup_area = $pickup_area

onready var base = get_node("/root/base")


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
		velocity = lerp(velocity, direction.normalized() * speed, acceleration * delta * 100)
		state = "walk"
		
		# horizontal flips
		if direction.x > 0:
			sprite.scale.x = -abs(sprite.scale.x)
		elif direction.x < 0:
			sprite.scale.x = abs(sprite.scale.x)
			
	# if the player is not moving, slowing down & friction
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction * delta * 100)
		state = "idle"
	
	# attack animation
	if Input.is_action_just_pressed('attack') && canmove:
		state = "attack"

		
	anim.travel(state)
	velocity = move_and_slide(velocity)


func check_items():
	# check items around to show animation
	if pickup_area.get_overlapping_areas().size() > 0:
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
	
	
func _physics_process(delta):
	var direction = get_input()
	move(direction, delta)
	
	check_items()
	
	



