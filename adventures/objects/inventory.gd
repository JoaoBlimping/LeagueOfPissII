extends Sprite

onready var room = get_node("/root/room")
onready var list = get_node("scroller/list")
onready var item = preload("item.tscn")
onready var thing = preload("../thing.gd")

func _ready():
	var items = {}
	for i in global.state["inventory"]:
		if (not items.has(i)):
			items[i] = 1
			var ib = item.instance()
			ib.set_tooltip("%s\n%s" % [i, repository.items[i].description])
			ib.get_node("sprite").set_texture(repository.items[i].texture)
			ib.connect("button_down",self,"press",[i])
			list.add_child(ib)
			ib.name = i
		else:
			items[i] += 1
	
	for i in items:
		if (items[i] > 1):
			list.get_node("%s/count" % i).text = "%d" % items[i]

func close(ended=false):
	if (ended): room.gui = false
	queue_free()

"""
" Called when an item is selected in the inventory.
" Has to handle three circumstances: normal items, items that are used within
" the inventory, and the merging of two items within the inventory.
"""
func press(held):
	room.gui = false
	# add speaker to the room for the item.
	var actives = room.get_node("actives")
	if (!actives.has_node(held+"_item")):
		var node = thing.new()
		node.realName = held
		node.name = held+"_item"
		actives.add_child(node)
	# if user is trying to merge two items.
	if (room.item):
		var new = null;
		if (repository.items[room.item].has("merge")):
			if (repository.items[room.item]["merge"].has(held)):
				new = repository.items[room.item]["merge"][held]
		elif (repository.items[held].has("merge")):
			if (repository.items[held]["merge"].has(room.item)):
				new = repository.items[held]["merge"][room.item]
		if (new):
			global.addToInventory(new)
			global.removeFromInventory(held)
			global.removeFromInventory(room.item)
			room.say(
				"%s and %s merged into... %s!!!" % [held, room.item, new],
				"_god_"
			)
		else: room.say(
			"%s and %s cannot be merged sorry." % [held, room.item],
			"_god_"
		)
		room.removeItem()
	# user is just getting an item like normal
	elif (global.itemProperty(held, "use")): room.run(held, held+"_item")
	else: room.useItem(held)
	close()