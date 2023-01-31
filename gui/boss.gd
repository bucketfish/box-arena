extends Control


onready var namelabel = $VBoxContainer/name
onready var desclabel = $VBoxContainer/desc
onready var healthvar = $VBoxContainer/HBoxContainer/health/value
onready var damagevar = $VBoxContainer/HBoxContainer/damage/value
onready var timer = $animtimer
onready var bossbar = $HBoxContainer2
onready var bosshealth = $HBoxContainer2/Control2/ProgressBar
onready var bosssprite = $HBoxContainer2/Control/Sprite
	
onready var anim = $anim

var animon = false setget anim_on

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_boss_bar()

func set_boss(boss):
	namelabel.text = boss
	desclabel.text = Data.bosses[boss]['desc']
	healthvar.text = str(Data.bosses[boss]['health'])
	damagevar.text = str(Data.bosses[boss]['damage'])
	
	bosshealth.max_value = Data.bosses[boss]['health']
	bosshealth.value = bosshealth.max_value
	
	bosssprite.frame = ['sol', 'nyam', 'pionk', 'flickflack', 'kickee', 'ticktack', 'conkydonk', 'fishymoo', 'tictactoe', 'slurpydoo', 'poinkydirtie', 'swooshymooshy', 'foofeefoofee', "puffpuffiepuff"].find(boss)
	
	if !animon:
		anim.play("show")
		animon = true
		show_boss_bar()
	
	timer.start()
	yield(timer, "timeout")
	
	if animon:
		anim.play_backwards("hide")
		animon = false

func anim_on(newval):
	if newval == false && animon == true:
		anim.play_backwards("hide")
	animon = newval

func show_boss_bar():
	bossbar.visible = true
	
func hide_boss_bar():
	bossbar.visible = false

func boss_health(health, maxhealth):
	bosshealth.value = health
	if health <= 0:
		hide_boss_bar()

func position_boss_bar():
	var tween = $Tween
	tween.interpolate_property(bossbar, "rect_global_position", bossbar.rect_global_position,  Vector2(bossbar.rect_global_position.x, namelabel.rect_position.y + 310 - 56), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func lower_boss_bar():
	var tween = $Tween
	tween.interpolate_property(bossbar, "rect_global_position", bossbar.rect_global_position,  Vector2(bossbar.rect_global_position.x, 503), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
