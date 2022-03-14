extends Control

onready var shade = $"../shade"
onready var rowbox = $scroll/rowbox

onready var row = [$scroll/rowbox/row, $scroll/rowbox/row2, $scroll/rowbox/row3, $scroll/rowbox/row4]

var row_scene = preload("res://gui/row.tscn")

onready var curhighlight = $scroll/rowbox/row/item
onready var itemdesc = $info/itemdesc
onready var itemdisplay_name = $info/itemname
onready var itemdisplay_sprite = $itemdisplay/sprite
onready var itemdisplay_count = $itemdisplay/count

onready var val_energy = $info/holder/values/energy
onready var val_health = $info/holder/values/health
onready var val_damage = $info/holder/values/damage


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	connect_rows()

func toggle():
	visible = !visible
	shade.visible = visible
	display(Persistent.carrying)
	
	focus_on(row[0].col[0])
	
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
			focus_on(curhighlight.up)
			
		elif Input.is_action_just_pressed("ui_down") && curhighlight.down:
			focus_on(curhighlight.down)
		elif Input.is_action_just_pressed("ui_left") && curhighlight.left:
			focus_on(curhighlight.left)
		elif Input.is_action_just_pressed("ui_right") && curhighlight.right:
			focus_on(curhighlight.right)
		

func focus_on(newfocus):
	curhighlight.focused = false
	newfocus.focused = true
	curhighlight = newfocus
	
	if curhighlight.itemname:
		itemdesc.text = Data.items[curhighlight.itemname]["desc"]
		
		itemdisplay_sprite.texture = load("res://assets/items/" + curhighlight.itemname + ".png")
		if curhighlight.countint == 1:
			itemdisplay_count.text = ""
		else:
			itemdisplay_count.text = str(curhighlight.countint)
		itemdisplay_name.text = curhighlight.itemname
		
		if "energy" in Data.items[curhighlight.itemname].keys():
			val_energy.visible = true
			val_energy.text.text = str(Data.items[curhighlight.itemname]["energy"])
		else:
			val_energy.visible = false
			
		if "health" in Data.items[curhighlight.itemname].keys():
			val_health.visible = true
			val_health.text.text = str(Data.items[curhighlight.itemname]["health"])
		else:
			val_health.visible = false
			
		if "damage" in Data.items[curhighlight.itemname].keys():
			val_damage.visible = true
			val_damage.text.text = str(Data.items[curhighlight.itemname]["damage"])
		else:
			val_damage.visible = false
			
		
		
