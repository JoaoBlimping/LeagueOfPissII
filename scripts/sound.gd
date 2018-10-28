extends AudioStreamPlayer

const POLY = 5

var song = null
var samplers = []
var priorities = []
var stamp = {"time":0, "sounds":[]}


func _ready():
	for i in range(POLY):
		var sampler = AudioStreamPlayer.new()
		add_child(sampler)
		sampler.connect("finished",self,"sampleDone",[i])
		samplers.append(sampler)
		priorities.append(0)
		


func song(file):
	if (song == file): return
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
	var currentTime = floor(OS.get_ticks_msec() / 100)
	if (stamp.time == currentTime and file in stamp.sounds): return
	
	for i in range(samplers.size()):
		if (priorities[i] < priority):
			if (currentTime != stamp.time):
				stamp.time = currentTime
				stamp.sounds.clear()
			
			stamp.sounds.append(file)
			samplers[i].stream = load("res://sounds/%s.wav" % file)
			samplers[i].play()
			priorities[i] = priority
			return samplers[i]

func sampleDone(i):
	priorities[i] = 0