extends Control

func _on_Play_pressed():
	AudioManager.play_sound("select.wav", Settings.sfx_volume, "SFX")
	Global.switch_scene("Levels/TestLevel.tscn")


func _on_Settings_pressed():
	AudioManager.play_sound("select.wav", Settings.sfx_volume)
	$Settings.show()
	$Main.hide()


func _on_Back_pressed():
	AudioManager.play_sound("select.wav", Settings.sfx_volume)
	$Settings.hide()
	$Main.show()
