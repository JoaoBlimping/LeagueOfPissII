extends Button

onready var pic = get_node("../..")

var speed = 100


func _ready():
	sound.song("dead")

func _process(delta):
	pic.region_rect.position -= Vector2(delta,delta) * speed
	pic.region_rect.position.x = fmod(pic.region_rect.position.x,pic.region_rect.size.x)
	pic.region_rect.position.y = fmod(pic.region_rect.position.y,pic.region_rect.size.y)

func _on_CheckBox_toggled(pressed):
	sound.song("dead" if !pressed else "haha")
	set_disabled(!pressed)
	pic.modulate.r = randf() * 5 if pressed else 1
	pic.modulate.g = randf() * 2 if pressed else 1
	pic.modulate.b = randf() if pressed else 1
	speed = 900 if pressed else 100

func _on_Button_button_down():
	global.loadGame()
	global.enterAdventure(global.area)
