extends Node

var root
var rng = RandomNumberGenerator.new()
onready var manager = get_node("/root/AudioManager")


func _ready():
	root = get_tree().get_root()
	pause_mode = Node.PAUSE_MODE_PROCESS


func _process(_delta):
	rng.randomize()


func play(sound,
				bus = "SFX",
				_menu = false,
				pitch = 1.0,
				random_pitch_scale = 0.0):
	var sounds = get_node("/root/AudioManager").get_children()
	for child in sounds:
		if child.is_in_group("Music") and bus == "Music":
			child.queue_free()
	
	var volume;
	if bus == "SFX":
		volume = Settings.sfx_volume
	elif bus == "Music":
		volume = Settings.mus_volume
	
	var soundPath = "res://Audio/" + sound
	var stream = load(soundPath)
	pitch = rng.randfn(pitch, random_pitch_scale)
	
	var player = AudioStreamPlayer.new()
	
	player.name = bus + "-" + str(rng.randi())
	manager.add_child(player)
	player.add_to_group(bus)
	player.set_stream(stream)
	player.set_bus(bus)
	player.set_volume_db(volume)
	player.pitch_scale = pitch
	player.play()
	
	var length = stream.get_length()
	var timer = Timer.new()
	
	timer.set_wait_time(length)
	timer.set_one_shot(true)
	timer.name = "Timer-" + player.name
	player.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	
	player.queue_free()
