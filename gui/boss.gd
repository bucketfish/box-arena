extends Control


onready var namelabel = $VBoxContainer/name
onready var desclabel = $VBoxContainer/desc
onready var healthvar = $VBoxContainer/HBoxContainer/health/value
onready var damagevar = $VBoxContainer/HBoxContainer/damage/value
onready var timer = $animtimer

onready var anim = $anim

var animon = false setget anim_on

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_boss(boss):
	namelabel.text = boss
	desclabel.text = Data.bosses[boss]['desc']
	healthvar.text = str(Data.bosses[boss]['health'])
	damagevar.text = str(Data.bosses[boss]['damage'])
	
	if !animon:
		anim.play("show")
		animon = true
	
	timer.start()
	yield(timer, "timeout")
	
	if animon:
		anim.play_backwards("show")
		animon = false

func anim_on(newval):
	if newval == false && animon == true:
		anim.play_backwards("show")
	animon = newval
