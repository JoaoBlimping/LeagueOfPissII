extends Node2D

onready var mangrove = preload("res://overworlds/mobs/mangrove.tscn")
onready var bomb = preload("res://overworlds/mobs/bomb.tscn")
onready var island = preload("res://overworlds/mobs/island.tscn")
onready var happyLemon = preload("res://overworlds/mobs/happyLemon.tscn")
onready var global = get_node("/root/global")
onready var clouds = get_node("ground/clouds")

const BONUS_RADIUS = 1.1

var points = {}

func _ready():
	var ocean = global.ocean if (global.ocean) else global.state["ocean"]
	var description = repository.loadJson("res://overworlds/maps/%s.json" % ocean)
	var sky = loadTexture(getOr(description, "sky", "sky"))
	var water = loadTexture(getOr(description, "water", "horizon"))
	var skyHeight = getOr(description, "skyHeight", 1)
	var waterDrift = getVector(description, "waterDrift")
	var skyDrift = getVector(description, "skyDrift")
	$ground.material.set_shader_param("sky", sky)
	$ground.material.set_shader_param("water", water)
	$ground.material.set_shader_param("waterDrift", waterDrift)
	performActions(getOr(description, "actions", []))
	if (global.point):
		var point = points[global.point]
		$things.cameraPosition = point["pos"]
		$things.cameraAngle = point["angle"]
	else:
		$things.cameraPosition.x = global.state["boatingPosition"]["x"]
		$things.cameraPosition.y = global.state["boatingPosition"]["y"]
		$things.cameraAngle = global.state["boatingAngle"]
	manageTapes()
	
func getOr(object, key, default):
	if (object.has(key)): return object[key]
	else: return default

func getVector(object, key):
	var vector = Vector2()
	if (!object.has(key)): return vector
	var pos = object[key]
	vector.x = getOr(pos, "x", 0)
	vector.y = getOr(pos, "y", 0)
	return vector

func getAngle(object, key):
	var angle = getOr(object, key, 0)
	match (angle):
		"north": return PI / 2
		"east": return 0
		"south": return -PI / 2
		"west": return PI
	return angle

func makeVector(object):
	return Vector2(getOr(object, "x", 0), getOr(object, "y", 0))

func addPoint(title, pos, angle):
	points[title] = {"pos": pos, "angle": angle}

func performActions(actions, pos=Vector2()):
	var width = 0
	for action in actions:
		var newWidth = performAction(action, pos)
		if (newWidth > width): width = newWidth
	return width

func performAction(action, pos=Vector2()):
	var type = getOr(action, "type", "place")
	var condition = getOr(action, "switch", null)
	if (condition and not global.getSwitch(condition)): return 0
	var actionPos = pos + getVector(action, "pos")
	var width = 0
	match type:
		"ab": width = performAb(action, actionPos)
		"place": width = performPlace(action, actionPos)
		"circle": width = performCircle(action, actionPos)
		"line": width = performLine(action, actionPos)
		"polygon": width = performPolygon(action, actionPos)
		"distribution": width = performDistribution(action, actionPos)
	var point = getOr(action, "point", null)
	if (point):
		var title = getOr(point, "name", "start")
		var angle = getAngle(point, "angle")
		addPoint(title, actionPos + Vector2(cos(angle), sin(angle)) * width * BONUS_RADIUS, angle)
	return width

func performAb(ab, pos=Vector2()):
	var options = getOr(ab, "options", [])
	if (options.empty()): return 0
	var i = randi() % options.size()
	return performAction(options[i], pos)

func performCircle(circle, pos=Vector2()):
	var radius = getOr(circle, "radius", 1)
	var actions = getOr(circle, "actions", [])
	var width = performActions(actions, pos + Vector2(0, radius)) * 2
	var circumference = PI * radius * 2
	for i in range(1, circumference / width):
		var out = pos
		out.x += cos(i) * radius
		out.y += sin(i) * radius
		performActions(actions, out)
	return radius + width / 2

func performPlace(place, pos=Vector2()):
	var mob = loadMob(getOr(place, "mob", "squid")).instance()
	$things.add_child(mob)
	mob.realPosition = pos
	mob.portal = getOr(place, "to", null)
	return mob.width / 2

func performLine(line, pos=Vector2()):
	var start = getVector(line, "start")
	var end = getVector(line, "end")
	var cap = getOr(line, "cap", false)
	var actions = getOr(line, "actions", [])
	var delta = end - start
	var count = delta.length() / (performActions(actions, start) * 2)
	for i in range(1, count): performActions(actions, start + delta / count * i)
	if (cap): performActions(actions, end)
	return delta.length()

func performPolygon(polygon, pos=Vector2()):
	var furthest = 0
	var points = getOr(polygon, "points", [])
	var close = getOr(polygon, "close", false)
	var actions = getOr(polygon, "actions", [])
	for i in range(1, points.size()):
		performLine({"actions": actions, "start": points[i - 1], "end": points[i]}, pos)
		var distance = makeVector(points[i - 1]).length()
		if (distance > furthest): furthest = distance
	if (close): performLine({"actions": actions, "start": points.back(), "end": points.front()}, pos)
	var endDistance = makeVector(points.back()).length()
	if (endDistance > furthest): furthest = endDistance
	return furthest
	
func performDistribution(distribution, pos=Vector2()):
	var n = getOr(distribution, "n", 1)
	var radius = getOr(distribution, "radius", 1)
	var actions = getOr(distribution, "actions", [])
	for i in range(n):
		var x = randDist() * radius
		var y = randDist() * radius
		performActions(actions, pos + Vector2(x,y))
	return radius

func loadTexture(key):
	return load("res://pics/backgrounds/%s.png" % key)

func loadMob(key):
	return load("res://overworlds/mobs/%s.tscn" % key)

func randDist():
	var theta = randf() * PI * 2
	var x = sin(theta)
	if (theta > PI): x += 1
	elif (theta < PI): x -= 1
	return x

func _input(event):
	if (event.is_action_pressed("ui_accept") and global.tapePlaying):
		sound.skip()

func manageTapes():
	while (true):
		global.tapePlaying = false
		var track = global.getNextTape()
		var details = repository.tapes[track]
		$hud/song.text = "%s by %s" % [details["title"], details["artist"]]
		yield(sound.song("tape", false), "finished")
		global.tapePlaying = true
		$hud/song.text = ""
		yield(sound.song(track, false, global.state["tapePosition"]), "finished")
		global.state["tapePosition"] = 0
		