extends Sprite

export var realPosition = Vector2()
export var width = 0.5
export (String)var portal = null
var realVelocity = Vector2()

func _ready():
	position.y = 300

func _process(delta):
	realPosition += realVelocity * delta