extends "../thing.gd"




onready var inventory = preload("inventory.tscn")


func _ready():
	pointer = "use"
	$healthBox/empty.region_rect.size.x = (global.state["reserve"]) * $healthBox/health.texture.get_width()

func _process(delta):
	$healthBox/health.region_rect.size.x = $healthBox/health.texture.get_width() * global.state["health"]

func _input(event):
	if (event.is_action_pressed("ui_accept") && !room.gui && poised):
		room.add_child(inventory.instance())
		room.gui = true