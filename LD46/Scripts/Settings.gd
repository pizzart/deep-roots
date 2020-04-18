extends Container

var sfx_volume = 0
var mus_volume = 0


func _on_SFX_Volume_value_changed(value):
	AudioManager.play_sound("select.wav", value)
	AudioServer.set_bus_volume_db(1, value)
	sfx_volume = value


func _on_Music_Volume_value_changed(value):
	AudioManager.play_sound("select.wav", value)
	AudioServer.set_bus_volume_db(2, value)
	mus_volume = value
