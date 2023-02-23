extends Control


onready var anim = $anim
onready var base = $"../.."
onready var cutscene = $curscene
onready var credits = $credits
onready var stats = $credits/stats


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func endgame():
	anim.play("fade")
	yield(anim, "animation_finished")
	yield(get_tree().create_timer(0.1), 'timeout')
	yield(base, 'next')
	base.anim.play("fade")
	yield(base.anim, "animation_finished")

	cutscene.visible = true
	base.anim.play_backwards("fade")
	yield(base.anim, "animation_finished")
	anim.play("cutscene")
	yield(anim, "animation_finished")
	yield(base, "next")
	credits.visible = true
	stats.text = "clear rooms: %s\ntime: %s" % [Functions.get_room_percent(), Functions.make_time(Persistent.timer)]
	
	anim.play("stats")
	yield(anim, "animation_finished")
	yield(base, "next")
	
	anim.play("credits")
	Persistent.save_game()
	yield(anim, "animation_finished")
	yield(base, "next")
	
	base.anim.play("fade")
	yield(base.anim, "animation_finished")
	visible = false
	base.anim.play_backwards("fade")
	yield(base.anim, "animation_finished")
	
