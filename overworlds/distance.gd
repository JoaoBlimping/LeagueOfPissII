extends Sprite

const LIMIT = 255

func _process(delta):
	var size = get_node("../../../things").cameraPosition.length() / LIMIT
	scale = Vector2(size,size)
