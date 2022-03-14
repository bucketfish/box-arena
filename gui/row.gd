extends HBoxContainer

onready var col = [$item, $item2, $item3, $item4]

func _ready():
	connect_focuses()
	
func connect_focuses():
	for num in range(0, 4):
		if num != 0:
			col[num].left = col[num-1]
		if num != 3:
			col[num].right = col[num+1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
