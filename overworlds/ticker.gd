extends Sprite

onready var things = get_node("../../../things")
onready var start = things.cameraPosition



func _process(delta):
	var newPos = things.cameraPosition
	var posDelta = newPos - start
	
	rotation += posDelta.length() / 15
	start = newPos