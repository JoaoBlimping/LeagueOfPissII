extends Sprite

onready var player = null
onready var cornerPos = get_node("friends/corner").position
onready var dispenser = get_node("friends/dispenser")
var healthDimensions

func _ready():
	set_process(true)
	healthDimensions = $health.get_texture().get_size()

func _process(delta):
	if (player == null): player = get_node("../actors/player")
	
	$health.set_region_rect(Rect2(0,0,healthDimensions.x * player.health,healthDimensions.y))
	
	if (abs(player.velocity.x) > 200): dispenser.position.x += player.velocity.x * delta
	if (dispenser.position.x < 0): dispenser.position.x = 0
	if (dispenser.position.x > cornerPos.x): dispenser.position.x = cornerPos.x
