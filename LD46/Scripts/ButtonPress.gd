extends Node

func press(show, hide):
	AudioManager.play("SFX/select.wav", Settings.sfx_volume, "SFX", true)
	show.show()
	hide.hide()
