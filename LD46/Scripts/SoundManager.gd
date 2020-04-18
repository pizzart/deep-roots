extends Node

var rng = RandomNumberGenerator.new()
var root = null

func _ready():
	root = get_tree().get_root()

func _process(delta):
	rng.randomize()

func play_sound(sound, volume):
	var soundPath = "res://Sounds" + sound
	var stream = load(soundPath)
	var player = AudioStreamPlayer.new()
	
	root.add_child(player)
	
	player.name = "Sound-" + str(rng.randi())
	player.set_owner(root)
	player.stream = stream
	player.set_volume_db(volume)
	player.play()
