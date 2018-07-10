extends Sprite

const LIMIT = 400

func _process(delta):
	var size = get_node("../../things").cameraPosition.length() / LIMIT
	scale = Vector2(size,size)
