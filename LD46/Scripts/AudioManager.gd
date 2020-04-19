extends Node

var rng = RandomNumberGenerator.new()
var root = null

func _ready():
	root = get_tree().get_root()

func _process(_delta):
	rng.randomize()

func play_sound(sound, volume, bus = "SFX"):
	var soundPath = "res://Audio/" + sound
	var stream = load(soundPath)
	var player = AudioStreamPlayer.new()
	
	player.name = "Sound-" + str(rng.randi())
	root.add_child(player)
	player.set_owner(root)
	player.stream = stream
	player.bus = bus
	player.set_volume_db(volume)
	player.play()
	
	var length = stream.get_length()
	var timer = Timer.new()
	
	timer.set_wait_time(length)
	timer.set_one_shot(true)
	timer.name = "Timer-" + player.name
	root.add_child(timer)
	timer.set_owner(root)
	yield(timer, "timeout")
	
	timer.queue_free()
	player.queue_free()
