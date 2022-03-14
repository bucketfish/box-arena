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

func items_custcomp(a, b):
	return Data.itemsorder.find( a ) < Data.itemsorder.find( b )
		

func sort_inventory(items) -> Dictionary:
	var dict = count_array(items)
	
	return dict

