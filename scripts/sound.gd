extends AudioStreamPlayer

const POLY = 5

var song = null
var samplers = []
var priorities = []


func _ready():
	for i in range(POLY):
		var sampler = AudioStreamPlayer.new()
		add_child(sampler)
		sampler.connect("finished",self,"sampleDone",[i])
		samplers.append(sampler)
		priorities.append(0)
		


func song(file):
	song = file
	stop()
	set_stream(load("res://songs/%s.ogg" % file))
	play()

func stopSong():
	stop()
	song = null

func getSong():
	return song

func sample(file,priority=1):
	for i in range(samplers.size()):
		if (priorities[i] < priority):
			samplers[i].stream = load("res://sounds/%s.wav" % file)
			samplers[i].play()
			priorities[i] = priority
			return samplers[i]

func sampleDone(i):
	priorities[i] = 0