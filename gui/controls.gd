extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var scroll = $scroll
onready var scrolltween = $scrolltween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_focus_changed():
	#https://godotengine.org/qa/5990/follow-focus-going-through-entries-inside-scroll-container
	var focused = get_focus_owner()
	var focus_size = focused.rect_size.y + 250
	var focus_top = focused.rect_position.y - 533

	var scroll_size = scroll.rect_size.y
	var scroll_top = scroll.scroll_vertical
	var scroll_bottom = scroll_top + scroll_size - focus_size
	
	var scroll_offset = scroll.scroll_vertical

	if focus_top < scroll_top || focus_top > scroll_bottom:
		scroll_offset = scroll_top + focus_top - scroll_bottom
	
	scrolltween.interpolate_property(scroll, "scroll_vertical",
		scroll.scroll_vertical, scroll_offset, 0.2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	scrolltween.start()


func _on_use_focus_entered():
	propagate_call("prep_button")
