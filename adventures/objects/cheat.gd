extends Panel

signal said

var TRUE = preload("res://pics/true.png")
var FALSE = preload("res://pics/false.png")

func _ready():
	for s in global.state["switches"]:
		$switches.add_item(s, TRUE if global.getSwitch(s) else FALSE)

func close():
	global.enterAdventure(global.state["area"])

func add():
	if ($text.text != "" and not global.hasSwitch($text.text)):
		global.setSwitch( $text.text, true)
		$switches.add_item($text.text, TRUE)
		$text.text = ""


func flip(index):
	var s = $switches.get_item_text(index)
	var value = not global.getSwitch(s)
	global.setSwitch(s, value)
	$switches.set_item_icon(index, TRUE if value else FALSE)
	

func room():
	$text.text = "%s:" % global.state["area"]
	$text.grab_focus()
	$text.caret_position = $text.text.length()
