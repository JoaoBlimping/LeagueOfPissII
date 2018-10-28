extends Node2D

const item = preload("item.gd")
var items = {}


func _ready():
	global.connect("switch_set", self, "refresh")
	var going = false
	for child in get_children():
		items[child.name] = child
		if (global.getSwitch(child.name)):
			going = true
			get_parent().call_deferred("add_child", child.duplicate())
		remove_child(child)
	if (not going and not global.inInventory(name) and items.has("default")):
		get_parent().call_deferred("add_child", items["default"].duplicate())


# Reverts the multi item back to default and sets all the switches off
# If you are using compound switches and shit then DONT use this as it
# will fuck shit up.
# on the upside, you shouldn't really need to do so
func revert(name="", value=false):
	var parent = get_parent()
	for i in items:
		if (i == "default"):
			get_parent().call_deferred("add_child", items[i].duplicate())
			continue
			
		global.setSwitch(i, false)
		if (parent.has_node(i)): parent.get_node(i).queue_free()


# rebuilds the thing and sets the pics as they should be
func refresh(name="", value=false):
	if (not value): return
	var parent = get_parent()
	for i in items: if (parent.has_node(i)): get_parent().get_node(i).free()
	var any = false
	for i in items:
		if (global.getSwitch(i)):
			var newVersion = items[i].duplicate()
			get_parent().add_child(newVersion)
			if (newVersion is item): newVersion.connect("grabbed", global, "setSwitch", [i, false])
			any = true
	if (not any and items.has("default")):
		get_parent().add_child(items["default"].duplicate())