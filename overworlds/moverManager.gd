extends Node2D

const SPEED = 5
const ROTATION_SPEED = 2
const LIMIT = 1
onready var cameraAngle = global.boatingAngle
onready var cameraPosition = global.boatingPosition

onready var width = get_viewport_rect().size.x
onready var sound = get_node("../sound")
onready var ground = get_node("../ground")


func _process(delta):
	var velocity = Vector2()
	
	if (Input.is_action_pressed("ui_left")):
		cameraAngle -= delta * ROTATION_SPEED
	if (Input.is_action_pressed("ui_right")):
		cameraAngle += delta * ROTATION_SPEED
	if (Input.is_action_pressed("ui_up")):
		velocity.x = cos(cameraAngle) * SPEED
		velocity.y = sin(cameraAngle) * SPEED
	if (Input.is_action_pressed("ui_down")):
		velocity.x = cos(cameraAngle) * -SPEED
		velocity.y = sin(cameraAngle) * -SPEED
	
	while (cameraAngle > PI): cameraAngle -= PI * 2
	while (cameraAngle < -PI): cameraAngle += PI * 2
	
	var futurePosition = cameraPosition + velocity * delta
	
	for child in get_children():
		var theta = atan2(child.realPosition.y - futurePosition.y,child.realPosition.x - futurePosition.x) - cameraAngle
		while (theta > PI): theta -= PI * 2
		while (theta < -PI): theta += PI * 2
		var distance = abs((child.realPosition.y - futurePosition.y) / sin(cameraAngle + theta))
		child.position.x = width / 2 + theta / LIMIT * width / 2
		child.scale = Vector2(1,1) / distance
		child.z_index = 1000 - distance * 2
		
		# Detect collisions.
		if (distance < child.width):
			velocity.x = 0
			velocity.y = 0
			sound.play()
			if (child.portal != null):
				var bits = child.getPortal()
				var size = bits.size()
				if (size == 2): global.creature = bits[1]
				if (size > 0): global.exitBoat(bits[0],cameraPosition,cameraAngle)
	
	cameraPosition += velocity * delta
	
	ground.material.set_shader_param("pos",cameraPosition)
	ground.material.set_shader_param("angle",cameraAngle)