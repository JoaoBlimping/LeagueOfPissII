extends Sprite

onready var levelAnimator = get_node("../../anim")
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
var strafing = false
var health = 1
var bounds = Rect2(256,0,512,600)
var timer
var healthBox


# built in function which is used to set up some event thingies
func _ready():
	set_process(true)
	if ($hitbox): $hitbox.connect("area_entered",self,"hit")
	timer = Timer.new()
	add_child(timer)
	yield(get_tree(), "idle_frame")
	yield(itinerary(), C)
	queue_free()
	if (target): get_node("../..").finish(true)


# built in function which controls routines and animation
func _process(delta):
	#health display
	if (healthBox != null):
		healthBox.value = health
		print("fef")
	
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


func itinerary():
	yield()
	

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

	ib.mother = getMother()
	bullets.add_child(ib)
	ib.position = location
	if (speed != null): ib.speed = speed
	ib.velocity.x = -cos(angle) * ib.speed
	ib.velocity.y = -sin(angle) * ib.speed
	return ib


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

func move(target):
	while (true):
		yield(tick(0.1), C)
		var angle = target.angle_to_point(global_position)
		velocity.x = cos(angle) * speed
		velocity.y = sin(angle) * speed
		if ((position - target).length() <= velocity.length() * 0.1):
			velocity.x = 0
			velocity.y = 0
			break

func animateLevel(animation):
	levelAnimator.play(animation)
	yield(levelAnimator, "animation_finished")

func setHealth(amount):
	health = amount
	healthBox = get_node("../../hud/leftPanel/health")
	healthBox.max_value = amount
	healthBox.value = amount
	

func attack(title="..."):
	get_node("../../hud/leftPanel/attack").text = title

func naming(title):
	get_node("../../hud/leftPanel/name").text = title

func getMother():
	return self