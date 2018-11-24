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

func press(item):
	room.gui = false
	if (global.itemProperty(item,"use")):
		if (!room.has_node(item)):
			var node = thing.new()
			node.realName = item
			room.add_child(node)
			room.run(item,node)
		else:
			room.run(item,get_node(item))
	else:
		room.useItem(item)
	close()