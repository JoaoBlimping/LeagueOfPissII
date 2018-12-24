extends Node

signal switch_set

onready var switchParser = preload("res://scripts/switchParser.gd")

var state = {"health": 3, "reserve": 1, "switches":{}}
var saveFile
var ocean = null
var point = null
var tapePlaying = false

func _ready():
	resetMouse()

func getNextTape():
	if (state["tapePosition"] == 0):
		var tape = state["tapeQueue"][0]
		state["tapeQueue"].remove(0)
		state["tapeQueue"].append(tape)
		return tape
	else:
		return state["tapeQueue"].back()

func setSwitch(name, value):
	state["switches"][name] = value
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
	elif (state["switches"].has(type)): return state["switches"][type]
	else: return false

func hasSwitch(name):
	return state["switches"].has(name)

func addToInventory(name):
	state["inventory"].push_back(name)

func inInventory(name):
	return state["inventory"].count(name) > 0

func removeFromInventory(name):
	for i in range(state["inventory"].size()):
		if (state["inventory"][i] == name):
			state["inventory"].remove(i)
			return

func itemProperty(item, property):
	var properties = repository.items[item]
	if (properties.has(property)): return properties[property]
	else: return null

func exitBoat(map, position, angle):
	state["boatingPosition"]["x"] = position.x
	state["boatingPosition"]["x"] = position.y
	state["boatingAngle"] = angle
	state["area"] = map
	if (tapePlaying): state["tapePosition"] = sound.get_playback_position()
	get_tree().change_scene("res://adventures/adventures/%s.tscn" % map)

func enterBoat(map=null, start=null):
	ocean = map
	point = start
	if (ocean): state["ocean"] = ocean
	get_tree().change_scene("res://overworlds/overworlds/level.tscn")

func enterAdventure(map = null):
	if (map): state["area"] = map
	get_tree().change_scene("res://adventures/adventures/%s.tscn" % state["area"])

func resetMouse():
	Input.set_custom_mouse_cursor(repository.mice["normal.png"].pic)
	for mouse in repository.mice: repository.mice[mouse].priority = 0

func refreshMouse():
	var best = {"pic": repository.mice["normal.png"].pic, "priority": 0}
	for mouse in repository.mice:
		if (repository.mice[mouse].priority > best.priority):
			best.pic = repository.mice[mouse].pic
			best.priority = repository.mice[mouse].priority
	Input.set_custom_mouse_cursor(best.pic)

func setMouse(type,priority):
	repository.mice[type].priority += priority
	refreshMouse()

func removeMouse(type,priority):
	repository.mice[type].priority -= priority
	refreshMouse()

func saveGame():
	repository.saveJson("user://los2Save%d.pig" % saveFile, state)

func loadGame():
	state = repository.loadJson("user://los2Save%d.pig" % saveFile)

func end():
	get_tree().change_scene("res://menus/credits.tscn")

func vMod(a, b):
	while (a.x < b.position.x): a.x += b.size.x
	while (a.y < b.position.y): a.y += b.size.y
	while (a.x > b.position.x + b.size.x): a.x -= b.size.x
	while (a.y > b.position.y + b.size.y): a.y -= b.size.y
	return a
