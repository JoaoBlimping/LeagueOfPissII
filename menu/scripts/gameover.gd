extends Button


func _ready():
	sound.song("dead")

func _on_CheckBox_toggled(pressed):
	sound.song("dead" if !pressed else "haha")
	set_disabled(!pressed)

func _on_Button_button_down():
	global.loadGame()
	global.enterAdventure(global.area)
