extends "../mover.gd"

func control():
	while (true):
		realVelocity.x = randf() * 3 - 1.5
		realVelocity.y = randf() * 3 - 1.5
		yield(tick(0.5), "completed")