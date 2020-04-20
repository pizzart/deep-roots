extends Node

var rng = RandomNumberGenerator.new()
var root = null
onready var manager = get_node("/root/AudioManager")


func play(sound,
				bus = "SFX",
				menu = false,
				pitch = 1.0,
				random_pitch_scale = 0.0):
	var volume;
	if bus == "SFX":
		volume = Settings.sfx_volume
	elif bus == "Music":
		volume = Settings.mus_volume
	
	var soundPath = "res://Audio/" + sound
	var stream = load(soundPath)
	pitch = rng.randfn(pitch, random_pitch_scale)
	
	var player;
	if menu:
		player = AudioStreamPlayer.new()
	else:
		player = AudioStreamPlayer2D.new()
		# player.position.x = OS.window_size.x/2
		# player.position.y = OS.window_size.y/2
		
	player.name = bus + "-" + str(rng.randi())
	manager.add_child(player)
	player.set_owner(manager)
	player.set_stream(stream)
	player.set_bus(bus)
	player.set_volume_db(volume)
	player.set_pitch_scale(pitch)
	player.play()
	
	var length = stream.get_length()
	var timer = Timer.new()
	
	timer.set_wait_time(length)
	timer.set_one_shot(true)
	timer.name = "Timer-" + player.name
	manager.add_child(timer)
	timer.set_owner(manager)
	timer.start()
	yield(timer, "timeout")
	
	timer.queue_free()
	player.queue_free()


func _ready():
	root = get_tree().get_root()
	pause_mode = Node.PAUSE_MODE_PROCESS


func _process(_delta):
	rng.randomize()
