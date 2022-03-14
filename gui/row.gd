extends HBoxContainer

onready var col = [$item, $item2, $item3, $item4]

func _ready():
	connect_focuses()
	
func connect_focuses():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
