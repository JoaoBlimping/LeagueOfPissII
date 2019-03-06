extends Sprite

export var realPosition = Vector2()
export var width = 0.5
export (bool)var noClip = false
export (String)var portal = null
export (String)var voice = null
var realVelocity = Vector2()
var timer = Timer.new()

func _ready():
	position.y = 300
	add_child(timer)
	control()

func control():
	pass

func tick(time):
	timer.set_wait_time(time)
	timer.start()
	yield(timer, "timeout")

func getPortal():
	if (portal == null): return []
	elif (portal.find("?") >= 0):
		var bits = portal.split("?")
		return bits
	else:
		return [portal]