extends Control

onready var shade = $"../shade"
onready var bars = $"../bars"
onready var rowbox = $scroll/rowbox

onready var row = [$scroll/rowbox/row, $scroll/rowbox/row2, $scroll/rowbox/row3, $scroll/rowbox/row4, $scroll/rowbox/row5, $scroll/rowbox/row6, $scroll/rowbox/row7, $scroll/rowbox/row8, $scroll/rowbox/row9]

var row_scene = preload("res://gui/row.tscn")

onready var curhighlight = $scroll/rowbox/row/item
onready var itemdesc = $info/itemdesc
onready var itemdisplay_name = $info/itemname
onready var itemdisplay_sprite = $itemdisplay/sprite
onready var itemdisplay_count = $itemdisplay/count

onready var val_energy = $info/holder/values/energy
onready var val_health = $info/holder/values/health
onready var val_damage = $info/holder/values/damage
onready var val_maxh = $info/holder/values/max_health

onready var base = get_node("/root/base")

onready var scroll = $scroll
onready var scrolltween = $invtween

onready var instructions = $instructions

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	connect_rows()

func toggle():
	visible = !visible
	shade.visible = visible
	display()
	
	focus_on(row[0].col[0])
	
func reset_item():
	visible = false
	

func _on_focus_change():
	# https://godotengine.org/qa/5990/follow-focus-going-through-entries-inside-scroll-container
	var focused = curhighlight.get_parent()
	var focus_size = focused.rect_size.y
	var focus_top = focused.rect_position.y

	var scroll_size = scroll.rect_size.y
	var scroll_top = scroll.scroll_vertical
	var scroll_bottom = scroll_top + scroll_size - focus_size

	var scroll_offset = scroll.scroll_vertical
	if focus_top < scroll_top:
		scroll_offset = focus_top

	if focus_top > scroll_bottom:
		scroll_offset = scroll_top + focus_top - scroll_bottom
		
	scrolltween.interpolate_property(scroll, "scroll_vertical",
		scroll.scroll_vertical, scroll_offset, 0.2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	scrolltween.start()


func display():
	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
		"Shift": "⇧",
		"Tab": "↹"
	}
	var usee = InputMap.get_action_list("use")[0].as_text()
	var fusee = InputMap.get_action_list("fuse")[0].as_text()
	if usee in thing.keys():
		usee = thing[usee]
	if fusee in thing.keys():
		fusee = thing[fusee]
		
	instructions.text = "%s to use/equip, %s to fuse" % [usee.to_lower(), fusee.to_lower()]
	
	var items = Persistent.carrying
	var items_dict = Functions.sort_inventory(items)
	var rowc = 0
	var colc = 0
	var count = 0
	
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
			
	while rowc < row.size():
		row[rowc].col[colc].itemname = ""
		colc += 1
		if colc >= 4:
			colc = 0
			rowc += 1
		
	get_tree().call_group("inv_item", "prep_display")
	focus_on(curhighlight)

func connect_rows():
	for currow in range(0, row.size()):
		for curbox in range(0, 4):
			var box = row[currow].col[curbox]
			
			if currow != 0:
				box.up = row[currow-1].col[curbox]
			if currow != row.size()-1:
				box.down = row[currow+1].col[curbox]

func _input(event):
	if visible == true && base.paused == false:
		if Input.is_action_just_pressed("ui_up") && curhighlight.up:
			focus_on(curhighlight.up)
			
		elif Input.is_action_just_pressed("ui_down") && curhighlight.down:
			focus_on(curhighlight.down)
		elif Input.is_action_just_pressed("ui_left") && curhighlight.left:
			focus_on(curhighlight.left)
		elif Input.is_action_just_pressed("ui_right") && curhighlight.right:
			focus_on(curhighlight.right)
			
			
		elif Input.is_action_just_pressed("use"):
			use_item()
		elif Input.is_action_just_pressed("fuse"):
			fuse_item()

func focus_on(newfocus):
	curhighlight.focused = false
	newfocus.focused = true
	curhighlight = newfocus
	update_info()
	_on_focus_change()
	
func update_info():
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
			
			
		if "total_health" in Data.items[curhighlight.itemname].keys():
			val_maxh.visible = true
			val_maxh.text.text = str(Data.items[curhighlight.itemname]["total_health"])
		else:
			val_maxh.visible = false
			
	else:
		clear_info()
		
func clear_info():
	itemdesc.text = ""
	itemdisplay_sprite.texture = null
	itemdisplay_count.text = ""
	itemdisplay_name.text = ""
	val_energy.visible = false
	val_health.visible = false
	val_maxh.visible = false
	val_damage.visible = false
		

func use_item():
	var item = curhighlight.itemname
	if !item:
		return
		
	var usething = Data.items[item]
	var use = false
	
	# set item as hand weapon
	if 'weapon' in usething.keys():
		Persistent.weapon = item
		use = false

	if 'health' in usething.keys():

		# full health, and trying to increase
		if Persistent.health == Persistent.max_health && usething['health'] > 0:
			# failed usage?
			use = false

		# trying to increase health
		elif usething['health'] > 0:
			# heal as much as possible
			Persistent.health = min(Persistent.max_health, Persistent.health + usething["health"] )
			use = true
		
		# trying to remove health
		elif usething['health'] < 0:
			Persistent.damagesource = item
			Persistent.health += usething['health']
			use = true
			# check if you died after removing health

	if 'total_health' in usething.keys():
		Persistent.max_health += usething['total_health']
		use = true

	if 'energy' in usething.keys():
		if usething['energy'] > 0:
			Persistent.energy += usething['energy']
			use = true
			
	if use:
#		bars.update_bars()
		Persistent.carrying.erase(item)
		Persistent.sort_inv(Persistent.carrying)
		
		display()
		

func fuse_item():
	var item = curhighlight.itemname
	if !item:
		return
		
	if 'fusion' in Data.items[item].keys() && Persistent.carrying.count(item) >= 3:
		Persistent.carrying.append(Data.items[item]['fusion'])
		Persistent.carrying.erase(item)
		Persistent.carrying.erase(item)
		Persistent.carrying.erase(item)
		
		Persistent.sort_inv(Persistent.carrying)
		
		display()
