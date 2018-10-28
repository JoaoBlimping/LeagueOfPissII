extends Node

signal switch_set

onready var switchParser = preload("res://scripts/switchParser.gd")

var health = 4
var reserve = 1
var mice = {}
var creatures = {}
var items = {}
var inventory = []
var switches = {}
var boatingAngle = 0
var boatingPosition = Vector2(0,0)
var area = null
var creature = "redJelly"
var saveFile

func _enter_tree():
	preloadMice()
	preloadItems()
	preloadCreatures()
	resetMouse()

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

func setSwitch(name, value):
	switches[name] = value
	emit_signal("switch_set", name, value)

func getSwitch(name):
	return evaluateSwitches(switchParser.parseSwitches(name))

func evaluateSwitches(tree):
	var type = tree["type"]
	if (type in switchParser.OPERATORS):
		var left = null
		var right = null
		if (tree.has("left")): left = evaluateSwitches(tree["left"])
		if (tree.has("right")): right = evaluateSwitches(tree["right"])
		if (right == null and left == null):
			right = false
			left = false
		if (left == null): left = right
		if (right == null): right = left

		match(type):
			'&': return left and right
			'|': return left or right
			'^': return (left or right) and not (left and right)
			'!': return not(left and right)
	elif (switches.has(type)): return switches[type]
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
	file.open("user://los2Save%d.pig" % saveFile,File.WRITE)
	
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
	file.open("user://los2Save%d.pig" % saveFile,File.READ)
	area = file.get_line()
	switches.clear()
	# TODO: make it not fuckup when you do the thingy
	switches = JSON.parse(file.get_line()).result
	inventory = splitArray(file.get_line())
	boatingPosition = Vector2(float(file.get_line()),float(file.get_line()))
	boatingAngle = float(file.get_line())
	health = float(file.get_line())
	reserve = float(file.get_line())
	file.close()

func end():
	get_tree().change_scene("res://menus/credits.tscn")

func vMod(a, b):
	while (a.x < b.position.x): a.x += b.size.x
	while (a.y < b.position.y): a.y += b.size.y
	while (a.x > b.position.x + b.size.x): a.x -= b.size.x
	while (a.y > b.position.y + b.size.y): a.y -= b.size.y
	return a