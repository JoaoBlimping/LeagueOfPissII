extends "actor.gd"

export(NodePath) var creatorName = null;
export(int) var distance = 100;
var creator = null
var mother = null

func _ready():
	if (creatorName):
		creator = get_node(creatorName)
		mother = creator.getMother()

func _process(delta):
	if (creator):
		strafing = creator.strafing
		if (strafing):
			modulate.a = 0.2
			velocity = creator.velocity
		else:
			modulate.a = 1
			velocity *= 0
			var angle = position.angle_to_point(creator.position)
			position.x = cos(angle) * distance
			position.y = sin(angle) * distance
			position += creator.position

func getMother():
	return mother