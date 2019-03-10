extends Node2D

const CLIP = 200
const MOVE_CLIP = 100
const SPEED = 5
const ROTATION_SPEED = 2
const LIMIT = 1
var cameraAngle = 0
var cameraPosition = Vector2()

onready var ground = get_node("../ground")
onready var dimensions = get_viewport_rect().size

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
	
	var futurePosition = cameraPosition + velocity * delta
	
	for child in get_children():
		var distance = (child.realPosition - futurePosition).length()
		if (distance > CLIP && not child.noClip):
			child.position.x = -90000
			continue
		var theta = futurePosition.angle_to_point(child.realPosition) - cameraAngle - PI
		while (theta > PI): theta -= PI * 2
		while (theta < -PI): theta += PI * 2
		child.position.x = dimensions.x / 2 + theta / LIMIT * dimensions.x / 2
		child.scale = Vector2(2,2) / distance
		child.z_index = 1000 - distance * 2
		if (distance > MOVE_CLIP): continue
		
		child.realPosition += child.realVelocity * delta
		
		var soundDistance = int((distance + 1) * 30)
		if (randi() % (soundDistance * 2) == 5 and child.voice):
			var warped = dimensions
			warped.x += cos(theta - PI / 2) * soundDistance
			warped.y += sin(theta - PI / 2) * soundDistance
			sound.sample(child.voice, 1, 0.9 + randf() * 0.2, warped)
		
		# Detect collisions.
		if (distance < child.width / 2):
			velocity.x = 0
			velocity.y = 0
			sound.sample("bump")
			if (child.portal != null):
				var bits = child.getPortal()
				var size = bits.size()
				if (size == 2): global.state["creature"] = bits[1]
				if (size > 0): global.exitBoat(bits[0], cameraPosition, cameraAngle)
	
	#player
	cameraPosition += velocity * delta
	ground.material.set_shader_param("pos",cameraPosition)
	ground.material.set_shader_param("angle",cameraAngle)