extends Node

var dude = null
var target = null
var going = false

signal moved

func _ready():
	set_process(true)

func _process(delta):
	var angle = target.angle_to_point(dude.global_position)
	dude.velocity.x = cos(angle) * dude.speed
	dude.velocity.y = sin(angle) * dude.speed
	if ((dude.position - target).length() <= dude.velocity.length() * delta):
		dude.velocity.x = 0
		dude.velocity.y = 0
		emit_signal("moved")

func r(tar):
	target = tar.global_position
	going = true
	return self