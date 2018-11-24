extends Node

var tapes = {}
var mice = {}
var items = {}
var creatures = {}
var fish = {}

func _ready():
	preloadItems()
	preloadTapes()
	preloadCreatures()
	preloadMice()
	preloadFish()
	
func preloadItems():
	items = loadJson("res://repository/items.json")
	for k in items.keys(): items[k].texture = load("res://pics/icons/%s.png" % k)

func preloadTapes():
	tapes = loadJson("res://repository/tapes.json")

func preloadCreatures():
	creatures = loadJson("res://repository/creatures.json")

func preloadMice():
	var dir = Directory.new()
	dir.open("res://mice")
	dir.list_dir_begin()
	while (true):
		var file = dir.get_next()
		if (file == ""): break
		elif (!file.begins_with(".") and file.ends_with("png")): mice[file] = {"pic":load("res://mice/%s" % file),"priority":0}
	dir.list_dir_end()

func preloadFish():
	fish = loadJson("res://repository/fish.json")

func loadJson(filename):
	var file = File.new()
	if (file.open(filename, File.READ) != 0):
		printerr("file %s coul;dn't open" % filename)
	var content = JSON.parse(file.get_as_text())
	file.close()
	if (content.error_string): print(content.error_string)
	return content.result

func saveJson(filename, content):
	var file = File.new()
	file.open(filename, File.WRITE)
	file.store_string(JSON.print(content))
	file.close()