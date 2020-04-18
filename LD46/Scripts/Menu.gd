extends Control

func _on_Play_pressed():
	AudioManager.play_sound("select.wav", -20)
	Global.switch_scene("Levels/TestLevel.tscn")


func _on_Settings_pressed():
	AudioManager.play_sound("select.wav", -20)
	$Settings.show()
	$Main.hide()


func _on_Back_pressed():
	AudioManager.play_sound("select.wav", -20)
	$Settings.hide()
	$Main.show()
