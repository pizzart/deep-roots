extends Node

func press(show, hide):
	AudioManager.play_sound("select.wav", Settings.sfx_volume)
	show.show()
	hide.hide()
