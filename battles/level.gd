extends "res://adventures/puzzle.gd"

export var song = "battle"

var tier

func _enter_tree():
	add_child(preload("res://battles/objects/hud.tscn").instance())

func _ready():
	if (sound.getSong() != song): sound.song(song)