extends Control


onready var health = $health/hbox/value
onready var energy = $energy/hbox/value
onready var health_plus = $health/hbox/plus
onready var energy_plus = $energy/hbox/plus
onready var anim = $energy/anim
onready var healthbar = $health/hbox/value/healthbar

var add = preload("res://effects/bar_add_val.tscn")

var col_pos_top = "#d7ebba"
var col_pos_back = "#7ead73"

var curhealth = 5
var curenergy = 10

func _ready():
	update_bars()


func update_bars():
	health.text = str(Persistent.health) + '/' + str(Persistent.max_health)
	healthbar.value = Persistent.health
	healthbar.max_value = Persistent.max_health
	energy.text = str(Persistent.energy)
	
	if Persistent.health != curhealth:
		var curadd = add.instance()
		if Persistent.health - curhealth > 0:
			curadd.text = "+" + str(Persistent.health - curhealth)
		else:
			curadd.text = str(Persistent.health - curhealth)
		
		curadd.rect_position = Vector2()
		health_plus.add_child(curadd)
		curhealth = Persistent.health
		curadd.get_node("anim").play("show")
		yield(get_tree().create_timer(0.5), "timeout")
		curadd.queue_free()
		
		
	if Persistent.energy != curenergy:
		var curadd = add.instance()
		if Persistent.energy - curenergy > 0:
			curadd.text = "+" + str(Persistent.energy - curenergy)
		else:
			curadd.text = str(Persistent.energy - curenergy)
			
		curadd.rect_position = Vector2()
		
		energy_plus.add_child(curadd)
		curenergy = Persistent.energy
		
		curadd.get_node("anim").play("show")
		yield(get_tree().create_timer(0.5), "timeout")
		
		curadd.queue_free()
	
	
	if Persistent.energy <= 0:
		anim.play("no_energy")
	else:
		anim.play("RESET")
	

func no_energy():
	anim.get_animation("no_energy").set_loop(false)
	anim.play("no_energy")
	yield(anim, "animation_finished")
	anim.get_animation("no_energy").set_loop(true)
