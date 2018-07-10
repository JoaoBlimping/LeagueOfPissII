extends Node2D

onready var mangrove = preload("res://overworld/objects/mangrove.tscn")
onready var bomb = preload("res://overworld/objects/bomb.tscn")
onready var waves = preload("res://overworld/objects/waves.tscn")
onready var island = preload("res://overworld/objects/island.tscn")
onready var global = get_node("/root/global")
onready var clouds = get_node("ground/clouds")
var drifter = 0
var talking = false



func _ready():
	sound.song("sea")
	
	# Add some squids.
	for x in range(30):
		for y in range(30):
			if (x == 15 and y == 15):
				var ib = island.instance()
				$things.add_child(ib)
				ib.realPosition.x = x + randf()
				ib.realPosition.y = y + randf()
				continue
			
			if (randi() % 2 == 0): continue
			var ib = mangrove.instance() if randi() % 2 == 0 else bomb.instance()
			$things.add_child(ib)
			ib.realPosition.x = x + randf()
			ib.realPosition.y = y + randf()

func _process(delta):
	if (clouds):
		var angle = $things.cameraAngle
		var width = clouds.texture.get_width()
		drifter += delta
		
		clouds.region_rect.position.x = width / PI * 2 * (angle + drifter / 11) / 2