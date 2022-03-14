extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var highlight = $highlight
onready var sprite = $sprite
onready var count = $count

var itemname
var countint = 1

export var left_path:NodePath setget setnode_left
export var right_path:NodePath setget setnode_right
export var up_path:NodePath setget setnode_up
export var down_path:NodePath setget setnode_down

var left
var right
var up
var down

var focused = false setget highlight

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight(false) # Replace with function body.
	setnode_left(left_path)
	setnode_right(right_path)
	setnode_up(up_path)
	setnode_down(down_path)
	
func setnode_left(path):
	if path:
		left = get_node(path)
		left_path = path
	
func setnode_right(path):
	if path:
		right = get_node(path)
		right_path = path
		
func setnode_down(path):
	if path:
		down = get_node(path)
		down_path = path
	
func setnode_up(path):
	if path:
		up = get_node(path)
		up_path = path
	
func prep_display():
	if itemname:
		sprite.texture = load("res://assets/items/" + itemname + ".png")
	if countint == 1:
		count.text = ""
	else:
		count.text = str(countint)


func highlight(value):
	highlight.visible = value
	focused = value
