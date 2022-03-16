extends Node

func generate_loot(coords):#contents
	if coords in Persistent.places:
		return Persistent.places[coords]
		
	var price = 0
	if Persistent.isCoward:
		coords.x = coords.x - 1 if coords.x != 1 else coords.x
		coords.y = coords.y - 1 if coords.y != 1 else coords.y

	if abs(coords.x) > abs(coords.y):
		price = abs(coords.x)
	else:
		price = abs(coords.y)
	var contents = []
	
	while price > 0:
		var randomnum = randi()%int(price)+1
		var item = Data.loot[str(randomnum)][randi()%Data.loot[str(randomnum)].size()]
		price -= randomnum
		contents.append(item)
	
	Persistent.places[Persistent.coords] = contents
	return contents

func generate_boss(coords):
	var boss = ""
	var contents = []
	
	if coords in Persistent.genbosses.keys():
		if Persistent.genbosses[coords]['alive'] == true:
			boss = Persistent.genbosses[coords]['name']
		else:
			contents = Persistent.places[coords]
	else:
		var boss_level = pick_fightcoords(coords)
		Persistent.places[coords] = []
		
		
		boss = Data.bosslist[str(boss_level)][randi()%Data.bosslist[str(boss_level)].size()]
		
		Persistent.genbosses[coords] = {
			"name": boss,
			"alive": true
		}
		
		
	return {"boss": boss, "contents": contents}

func array_unique(array: Array) -> Array:
	var unique: Array = []
	for item in array:
		if not unique.has(item):
			unique.append(item)
	return unique
	
func count_array(array: Array) -> Dictionary:
	var dict: Dictionary = {}
	for item in array:
		if item in dict.keys():
			dict[item] += 1
		else:
			dict[item] = 1
	return dict
		

func sort_inventory(items) -> Dictionary:
	var dict = count_array(items)
	
	return dict


func pick_fightcoords(coords):
	var bigger = max(abs(coords.y), abs(coords.x))
	var smaller = min(abs(coords.y), abs(coords.x))
	return bigger if bigger in Data.fightplaces else smaller
