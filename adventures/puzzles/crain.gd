extends "../puzzle.gd"

const SPEED = 600
var ballSpeed = 400
var bounds = Rect2(0,0,1024,600)
var toKill = 0

func _ready():
	randomize()
	$magnet.linear_velocity = Vector2(ballSpeed,0).rotated(randi() * PI * 2)
	$magnet.connect("body_entered", self, "bounce")
	sound.song("crain")
	for box in $boxes.get_children():
		if (box.is_in_group("box")): toKill += 1

func _process(delta):
	if (Input.is_action_pressed("ui_left")): $hook.position.x -= SPEED * delta
	if (Input.is_action_pressed("ui_right")): $hook.position.x += SPEED * delta
	if ($magnet.position.y > 600): finish(false)

func bounce(other):
	sound.sample("bounce")
	if (other.is_in_group("box")):
		other.free()
		toKill -= 1
		if (toKill == 0):
			finish(true)