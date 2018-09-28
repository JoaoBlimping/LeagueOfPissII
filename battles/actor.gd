extends Sprite

onready var bullets = get_node("../../hud/bulletStuff/bullets")

const C = "completed"
const UP = PI / 2
const LEFT = 0
const RIGHT = PI
const DOWN = -PI / 2

export var flippy = false
export var walky = false
export var target = true
export var speed = 100

var velocity = Vector2(0,0)
var health = 1
var bounds = Rect2(256,0,512,600)
var timer


# built in function which is used to set up some event thingies
func _ready():
	set_process(true)
	$hitbox.connect("area_entered",self,"hit")
	timer = Timer.new()
	add_child(timer)


# built in function which controls routines and animation
func _process(delta):
	#move
	position += velocity * delta
	if (flippy):
		if (velocity.x < 0): set_flip_h(true)
		if (velocity.x > 0): set_flip_h(false)

	#animate
	if (walky):
		if (velocity.length() == 0): $animation.stop()
		elif (!$animation.is_playing()):
			$animation.play("walk")


# Fires a copy of a given bullet at a given angle, and also optionally from an origin object.
func shoot(bullet,angle,origin=self):
	return shootFrom(bullet,angle,origin.global_position)


# Fires a copy of a given object at a given angle from a given vector position and optionally at a
# given speed, otherwise using the default.
func shootFrom(bullet,angle,location,speed=null):
	var ib = bullet.instance()
	if (ib.sound != null):
		sound.sample(ib.sound)
		pass

	ib.mother = self
	bullets.add_child(ib)
	ib.position = location
	if (speed != null): ib.speed = speed
	ib.velocity.x = -cos(angle) * ib.speed
	ib.velocity.y = -sin(angle) * ib.speed
	return ib


func die():
	if (target): get_node("../..").finish(true)


# This gets called when an actor is hit by a bullet or powerup which is a kind of bullet anyway
func hit(body):
	if (body.is_in_group("bullet") and not body.is_in_group("power") and body.mother != self):
		if (randi() % 5 > 3): bullets.addPowerup(body.position)
		body.queue_free()
		health -= 1
		return true
	return false


# runs for a specified amount of time
func tick(time):
	timer.set_wait_time(time)
	timer.start()
	yield(timer, "timeout")
	return

func naming(title):
	get_node("../../hud/leftPanel/name").text = title