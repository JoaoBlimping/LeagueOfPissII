extends Node2D

onready var screen = get_viewport().size
onready var power = preload("bullets/power.tscn")
var lifeRect

signal cleared

func _ready():
	set_process(true)
	lifeRect = Rect2(250,-4,524,608)
	
func _process(delta):
	var bullets = get_children()
	
	for bullet in bullets:
		var pos = bullet.position
		bullet.position += bullet.velocity * delta
		bullet.velocity += bullet.acceleration * delta
		if (!lifeRect.has_point(pos)):
			if (!bullet.is_in_group("power") || !(pos < screen)):
				bullet.queue_free()

func addPowerup(pos):
	var ib = power.instance()
	ib.add_to_group("power")
	
	add_child(ib)
	ib.position = pos
	ib.velocity.x = 0
	ib.velocity.y = 100

func clear():
	get_node("../bulletAnimator").play("out")
	return self
	
func outFinished(anim):
	modulate.a = 1
	var children = get_children()
	for child in children:
		child.queue_free()
	emit_signal("cleared")