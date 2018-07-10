extends VideoPlayer

signal finished
var done = false
var going = false

func _ready():
	set_autoplay(true)
	set_process(true)

func _process(delta):
	if (!done and get_stream_pos() >= 0):
		stop()
		done = true
		
	if (!is_playing() and going): emit_signal("finished")

func play():
	going = true
	.play()
