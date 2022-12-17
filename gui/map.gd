extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapitem = preload("res://gui/mapitem.tscn")

onready var grid = $GridContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func toggle():
	visible = !visible
	
	if visible:
		show_map()
		
		
func show_map():
	for node in grid.get_children():
		node.queue_free()
	
	for y in range(-10, 11):
		for x in range(-10, 11):
			var item = mapitem.instance()
			
			var frame = Functions.mapicon_num(Vector2(x, -y))
			
			item.get_node("Sprite").frame = frame
			
			
			grid.add_child(item)

