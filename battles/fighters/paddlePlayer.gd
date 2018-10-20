extends "../actor.gd"

const NORMAL_SPEED = 222
const STRAFE_SPEED = 129

onready var heart = get_node("hitbox/heart")
onready var bullet = preload("../bullets/fogle.tscn")
onready var dispenser = get_node("../../hud/friends/dispenser")


var ticker = 0
var hurting = -1


func _ready():
	health = global.health if global.health < 3 else 3


func hit(body):
	if (body.is_in_group("power")): body.position = dispenser.global_position
	elif (hurting < 0):
		if (.hit(body)):
			global.health -= 1
			sound.sample("ow")
			hurting = 1
			modulate.a = 0.2
			modulate.r = 2
			if (health < 1): die()
			
	
	
func die():
	get_node("../..").finish(false)


func _process(delta):
	#moving
	velocity.x = 0
	if (Input.is_action_pressed("ui_left")): velocity.x = -speed
	if (Input.is_action_pressed("ui_right")): velocity.x = speed
	
	if (position.x < bounds.position.x): position.x = bounds.position.x
	if (position.x > bounds.position.x + bounds.size.x): position.x = bounds.position.x + bounds.size.x