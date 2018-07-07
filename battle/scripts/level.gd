extends "res://adventure/scripts/puzzle.gd"

export var song = "battle"

func _enter_tree():
	add_child(preload("res://battle/objects/hud.tscn").instance())

func _ready():
	var sound = get_node("/root/sound")
	if (sound.getSong() != song): sound.song(song)