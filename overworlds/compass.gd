extends Sprite

func _process(delta):
	rotation = 0 - get_node("../../../things").cameraAngle
