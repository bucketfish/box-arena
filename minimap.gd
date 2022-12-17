extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var find = ['sol', 'nyam', 'pionk', 'flickflack', 'kickee', 'ticktack', 'conkydonk', 'fishymoo', 'tictactoe', 'slurpydoo', 'poinkydirtie', 'swooshymooshy', 'foofeefoofee', "puffpuffiepuff"]


onready var sprites = [$"1", $"2", $"3", $"4", $"5", $"6", $"7", $"8"]
var locs = [
	Vector2(-1, 1),
	Vector2(0, 1),
	Vector2(1, 1),
	Vector2(1, 0),
	Vector2(1, -1),
	Vector2(0, -1),
	Vector2(-1, -1),
	Vector2(-1, 0)
]
var positions = [Vector2(-1, -1)]
onready var texture = $Control/TextureRect
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_minimap():
#	visible = true
	
	for node in sprites:
		node.visible = true
	
	texture.rect_position.x = -32
	texture.rect_position.y = -32
	
	if Persistent.coords.x == -10:
		texture.rect_position.x = 32
		sprites[0].visible = false
		sprites[6].visible = false
		sprites[7].visible = false
	elif Persistent.coords.x == 10:
		texture.rect_position.x = -96
		sprites[2].visible = false
		sprites[3].visible = false
		sprites[4].visible = false

		
	if Persistent.coords.y == 10:
		texture.rect_position.y = 32
		sprites[0].visible = false
		sprites[1].visible = false
		sprites[2].visible = false
		
	elif Persistent.coords.y == -10:
		texture.rect_position.y = -96
		sprites[4].visible = false
		sprites[5].visible = false
		sprites[6].visible = false
		
		
	for i in range(0, 8):
		var curloc = Persistent.coords + locs[i]
		var frame = 15
		if sprites[i].visible:
			sprites[i].frame = Functions.mapicon_num(curloc)
		
					
					
