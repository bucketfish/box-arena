extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var cards = [$save, $save2, $save3]
onready var play_label = $RichTextLabel
onready var label_tween = $RichTextLabel/Tween
onready var mainmenu = $".."



# Called when the node enters the scene tree for the first time.
func _ready():
	play_label.visible = false


func prepare_saves():
	Persistent.load_thumbnails()
	for i in Persistent.thumbnails.keys():
		if 'weapon' in Persistent.thumbnails[i].keys(): # save exists
			cards[i].display_thumbnail(Persistent.thumbnails[i])
			
		else:
			cards[i].display_none()
			
	
	
func place_playlabel(cardnum):
	if !play_label.visible:
		play_label.rect_global_position = cards[cardnum].rect_global_position
		play_label.rect_global_position.y -= 81
		
	else:
		label_tween.interpolate_property(play_label, "rect_global_position", play_label.rect_global_position, Vector2(cards[cardnum].rect_global_position.x, cards[cardnum].rect_global_position.y - 81), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		label_tween.start()
		
	play_label.visible = true

func _on_save_focus_entered():
	place_playlabel(0)
	

func _on_save2_focus_entered():
	place_playlabel(1)


func _on_save3_focus_entered():
	place_playlabel(2)


func _on_play_focus_entered():
	play_label.visible = false
