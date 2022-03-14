extends Control

onready var shade = $"../shade"

onready var row = [$scroll/rowbox/row, $scroll/rowbox/row2, $scroll/rowbox/row3, $scroll/rowbox/row4]

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func toggle():
	visible = !visible
	shade.visible = visible
	display(Persistent.carrying)
	
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
			
	get_tree().call_group("inv_item", "prep_display")
