extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var curcount
var curt = 0
var totalc

onready var label = $Label
onready var base = get_node("/root/base")
onready var tween = $Tween
signal pressed
var text = [
	"the gate is hanging loosely off its hinges",
	"leading into dark stairs into darker rooms",
	"into doors hiding darker secrets",
	"the door is wide open - the only question that remains",
	"adventurer, is whether you will step through it",
	"and into the box arena."
]
onready var typing = $typing

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = '\n'.join(text)



func start_intro():
	curcount = 0
	curt = 0
	label.percent_visible = 0
	yield(get_tree().create_timer(0.5), "timeout")

	while curt < text.size():
		curcount += text[curt].length() - text[curt].count(" ") + 1


		tween.interpolate_property(label, "percent_visible",
		label.percent_visible, float( float(curcount) / (label.text.length() - label.text.count(" "))), 0.4,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		typing.play()
		yield(get_tree().create_timer(0.1), 'timeout')
		yield(base, 'next')	
		curt += 1
	
	base.anim.play("fade")
	yield(base.anim, "animation_finished")
	self.visible = false
	base.state = "play"
	base.anim.play_backwards("fade")
	base.update_trans(false)
	# close the intro


func _on_Tween_tween_completed(object, key):
	typing.stop()
