extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_minimap():
	pass
	# 1. check what's in each room
	# 2. do we need .. . like monster icons... argh i guess so
	# icon for LOOT
	# and then show either icon or LOOT. or NOTHING
	# and a generic 'monster' icon for big maps, for rooms you haven't encountered
	# sigh ok another set of things to do i guess!
	# then in each monster's database we need to insert the icons again
