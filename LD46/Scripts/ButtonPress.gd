extends Node

func press(show, hide):
	AudioManager.play("SFX/select.wav", "SFX", true)
	show.show()
	hide.hide()
