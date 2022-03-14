extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var highlight = $highlight
onready var sprite = $sprite
onready var count = $count

var itemname
var countint = 1

var left
var right
var up
var down

var focused = false setget highlight

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight(false) # Replace with function body.
	
	
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
