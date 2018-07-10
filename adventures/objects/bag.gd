extends "../thing.gd"




onready var inventory = preload("inventory.tscn")


func _ready():
	pointer = "use"

func _input(event):
	if (event.is_action_pressed("ui_accept") && !room.gui && poised):
		room.add_child(inventory.instance())
		room.gui = true