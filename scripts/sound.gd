extends AudioStreamPlayer

const POLY = 5

var song = null
var samplers = []
var positionalSamplers = []
var priorities = []
var stamp = {"time":0, "sounds":[]}


func _ready():
	for i in range(POLY):
		var sampler = AudioStreamPlayer.new()
		add_child(sampler)
		sampler.connect("finished",self,"sampleDone",[i])
		samplers.append({"sampler": sampler, "priority": 0})
		var positionalSampler = AudioStreamPlayer2D.new()
		add_child(positionalSampler)
		positionalSampler.connect("finished", self, "sampleDone", [i, true])
		positionalSamplers.append({"sampler": positionalSampler, "priority": 0})


func song(file, repeat=true, start=0):
	if (song == file): return
	song = file
	stop()
	var stream = load("res://songs/%s.ogg" % file)
	stream.loop = repeat
	set_stream(stream)
	play(start)
	return self

func stopSong():
	stop()
	song = null

func skip():
	stopSong()
	emit_signal("finished")

func getSong():
	return song

func sample(file,priority=1, pitch=1.0, pos=null):
	var currentTime = floor(OS.get_ticks_msec() / 100)
	if (stamp.time == currentTime and file in stamp.sounds): return
	
	var sampleSet = samplers
	if (pos): sampleSet = positionalSamplers
	
	for i in range(sampleSet.size()):
		if (sampleSet[i]["priority"] < priority):
			if (currentTime != stamp.time):
				stamp.time = currentTime
				stamp.sounds.clear()
			
			stamp.sounds.append(file)
			sampleSet[i]["sampler"].stream = load("res://sounds/%s.wav" % file)
			sampleSet[i]["sampler"].pitch_scale = pitch
			if (pos): sampleSet[i]["sampler"].position = pos
			sampleSet[i]["sampler"].play()
			sampleSet[i]["priority"] = priority
			return sampleSet[i]

func sampleDone(i, positional=false):
	var sample = samplers[i] if (not positional) else positionalSamplers[i]
	sample["priority"] = 0