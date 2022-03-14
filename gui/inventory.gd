extends Control

onready var shade = $"../shade"
onready var rowbox = $scroll/rowbox

onready var row = [$scroll/rowbox/row, $scroll/rowbox/row2, $scroll/rowbox/row3, $scroll/rowbox/row4]

var row_scene = preload("res://gui/row.tscn")

onready var curhighlight = $scroll/rowbox/row/item

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	connect_rows()

func toggle():
	visible = !visible
	shade.visible = visible
	display(Persistent.carrying)
	
	curhighlight.focused = false
	row[0].col[0].focused = true
	curhighlight = row[0].col[0]
	
func display(items):
	var items_dict = Functions.sort_inventory(items)
	var rowc = 0
	var colc = 0

	for i in items_dict.keys():
		row[rowc].col[colc].itemname = i
		row[rowc].col[colc].countint = items_dict[i]
		
		colc += 1
		if colc >= 4:
			colc = 0
			rowc += 1
			
		if rowc >= row.size():
			var newrow = row_scene.instance()
			rowbox.add_child(newrow)
			row.append(newrow)
			connect_rows()
			
	get_tree().call_group("inv_item", "prep_display")

func connect_rows():
	for currow in range(0, row.size()):
		for curbox in range(0, 4):
			var box = row[currow].col[curbox]
			
			if currow != 0:
				box.up = row[currow-1].col[curbox]
			if currow != row.size()-1:
				box.down = row[currow+1].col[curbox]

func _input(event):
	if visible == true:
		if Input.is_action_just_pressed("ui_up") && curhighlight.up:
			curhighlight.focused = false
			curhighlight.up.focused = true
			curhighlight = curhighlight.up
		elif Input.is_action_just_pressed("ui_down") && curhighlight.down:
			curhighlight.focused = false
			curhighlight.down.focused = true
			curhighlight = curhighlight.down
		elif Input.is_action_just_pressed("ui_left") && curhighlight.left:
			curhighlight.focused = false
			curhighlight.left.focused = true
			curhighlight = curhighlight.left
		elif Input.is_action_just_pressed("ui_right") && curhighlight.right:
			curhighlight.focused = false
			curhighlight.right.focused = true
			curhighlight = curhighlight.right
		
