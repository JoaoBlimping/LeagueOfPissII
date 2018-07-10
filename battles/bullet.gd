extends Area2D

export var speed = 150
export (String) var sound

var mother = null
var velocity = Vector2(0,0)
var acceleration = Vector2(0,0)

func _ready():
	add_to_group("bullet")

func retarget(angle,newSpeed = null):
	if (newSpeed == null): newSpeed = speed
	velocity.x = -cos(angle) * newSpeed
	velocity.y = -sin(angle) * newSpeed

func gravify(angle,power):
	acceleration.x = -cos(angle) * power
	acceleration.y = -sin(angle) * power

func damp(multiplier):
	velocity *= multiplier