extends Node

var health = 4
var reserve = 1
var mice = {}
var creatures = {}
var items = {}
var inventory = []
var switches = {}
var boatingAngle = 0
var boatingPosition = Vector2()
var area = null
var creature = "redJelly"
var saveFile

func _enter_tree():
	preloadMice()
	preloadItems()
	preloadCreatures()

func restart():
	for i in range(inventory.size()): inventory.remove(0)
	switches.clear()
	area = null

func preloadItems():
	var file = File.new()
	file.open("res://adventures/items.json",File.READ)
	items = JSON.parse(file.get_as_text()).result
	for k in items.keys(): items[k].texture = load("res://pics/icons/%s.png" % k)


func preloadCreatures():
	var file = File.new()
	file.open("res://creatures.json",File.READ)
	creatures = JSON.parse(file.get_as_text()).result

func setSwitch(name,value):
	switches[name] = value

func getSwitch(name):
	if (switches.has(name)): return switches[name]
	else: return false

func hasSwitch(name):
	return switches.has(name)

func addToInventory(name):
	inventory.push_back(name)

func inInventory(name):
	return inventory.count(name) > 0

func removeFromInventory(name):
	for i in range(inventory.size()):
		if (inventory[i] == name):
			inventory.remove(i)
			return

func itemProperty(item,property):
	var properties = items[item]
	if (properties.has(property)): return properties[property]
	else: return false

func exitBoat(map,position,angle):
	boatingPosition = position
	boatingAngle = angle
	area = map
	get_tree().change_scene("res://adventures/adventures/%s.tscn" % map)

func enterBoat():
	get_tree().change_scene("res://overworlds/overworlds/level.tscn")

func enterAdventure(map):
	area = map
	get_tree().change_scene("res://adventures/adventures/%s.tscn" % area)

func preloadMice():
	var dir = Directory.new()
	dir.open("res://mice")
	dir.list_dir_begin()
	while (true):
		var file = dir.get_next()
		if (file == ""): break
		elif (!file.begins_with(".") and file.ends_with("png")): mice[file] = {"pic":load("res://mice/%s" % file),"priority":0}
	dir.list_dir_end()

func resetMouse():
	Input.set_custom_mouse_cursor(mice["normal.png"].pic)
	for mouse in mice: mice[mouse].priority = 0

func refreshMouse():
	var best = {"pic":mice["normal.png"].pic,"priority":0}
	for mouse in mice:
		if (mice[mouse].priority > best.priority):
			best.pic = mice[mouse].pic
			best.priority = mice[mouse].priority
	Input.set_custom_mouse_cursor(best.pic)

func setMouse(type,priority):
	mice[type].priority += priority
	refreshMouse()

func removeMouse(type,priority):
	mice[type].priority -= priority
	refreshMouse()

func joinArray(array):
	var output = ""
	for i in range(array.size()):
		output += array[i] + ("@^@" if i != array.size() - 1 else "")
	return output

func splitArray(string):
	return Array(string.split("@^@"))
	

func saveGame():
	var file = File.new()
	file.open("user://losSave%d.pig" % saveFile,File.WRITE)
	
	file.store_line(area)
	file.store_line(JSON.print(switches))
	file.store_line(joinArray(inventory))
	file.store_line(String(boatingPosition.x))
	file.store_line(String(boatingPosition.y))
	file.store_line(String(boatingAngle))
	file.store_line(String(health))
	file.store_line(String(reserve))
	file.close()

func loadGame():
	var file = File.new()
	file.open("user://losSave%d.pig" % saveFile,File.READ)
	area = file.get_line()
	switches.clear()
	
	switches = JSON.parse(file.get_line()).result
	inventory = splitArray(file.get_line())
	boatingPosition = Vector2(float(file.get_line()),float(file.get_line()))
	boatingAngle = float(file.get_line())
	health = float(file.get_line())
	reserve = float(file.get_line())
	file.close()

func end():
	get_tree().change_scene("res://menus/credits.tscn")