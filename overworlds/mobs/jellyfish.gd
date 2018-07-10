extends "../mover.gd"


var timer = 0


func _process(delta):
	timer += delta * (randf() - 0.5)
	realVelocity.x = 2
	realVelocity.y = 2