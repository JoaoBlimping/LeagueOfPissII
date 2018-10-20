extends Node2D

var items = {}


func _ready():
	for child in get_children():
		items[child.name] = {"dude":child, "going":false}
		remove_child(child)
		if (child.name == "default"): get_parent().call_deferred("add_child", child.duplicate())

func _process(delta):
	var any = false
	for i in items:
		var active = global.getSwitch(i) and not global.inInventory(items[i]["dude"].realName)
		if (items[i]["going"] != active):
			if (active): get_parent().add_child(items[i]["dude"].duplicate())
			items[i]["going"] = active