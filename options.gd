extends Node

var keybinds = {} setget update_keybinds

var config = {} setget update_config


var savepath = "user://settings.save"


func update_keybinds(new):
	keybinds = new
	save_options()
	
func update_config(new):
	config = new
	
	update_audio_volume()
	
	save_options()
	
func update_audio_volume():
	
	
	for bus in ["master", "sfx", "music"]:
		
		if !(bus in config):
			config[bus] = 5
			
		var curbus:int

		match bus:
			"master":
				curbus = 0
			"sfx":
				curbus = 2
			"music":
				curbus = 1
		
		AudioServer.set_bus_volume_db(curbus, linear2db(config[bus] / 10))
#	AudioServer.set_bus_volume_db(_bus, linear2db(value))

	
func save_options():
	
	#prepares the file
	var saves = File.new()
	saves.open(savepath, File.WRITE)
	
	#vars to save
	var vals = {
		"keybinds": keybinds,
		"config": config
	}

	saves.store_line(to_json(vals))
	
	print("settings saved!")
	saves.close()
	#emit_signal("finish_save")
	

func load_options():
	
	var save_game = File.new()
	if not save_game.file_exists(savepath):
		yield(get_tree(), "idle_frame")
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open(savepath, File.READ)

	# Get the saved dictionary from the next line in the save file
	var vals = parse_json(save_game.get_line())
	
	for i in vals.keys():
		set(i, vals[i])

	save_game.close()
	update_audio_volume()
	print("settings loaded!")
	yield(get_tree(), "idle_frame")
