extends KinematicBody2D


var health
var damage
var invincible = false
export var type = "nyam"
const item = preload("res://items/item.tscn")
onready var base = get_node("/root/base")
onready var hitbox = $hitbox

func _ready():
	health = Data.bosses[type]["health"]
	damage = Data.bosses[type]["damage"]
	hitbox.damage = damage
	
func hurt(damageval):
	health -= damageval
	if health <= 0:
		die()
	

func die():
	for i in Data.bosses[type]["drop"]:
		var curitem = item.instance()
		curitem.itemname = i
		curitem.global_position = global_position + Vector2(rand_range(-40, 40), rand_range(-40, 40))
		base.curroom.call_deferred("add_child", curitem)
		
	queue_free()
