extends Control

func _on_Play_pressed():
	ButtonPress.press($Choose, $Main)


func _on_Settings_pressed():
	ButtonPress.press($Settings, $Main)


func _on_Back_pressed():
	ButtonPress.press($Main, $Settings)


func _on_BackChoose_pressed():
	ButtonPress.press($Main, $Choose)

func _on_Story_pressed():
	AudioManager.play_sound("select.wav", Settings.sfx_volume)
	Global.switch_scene("Levels/TestLevel.tscn")


func _on_Endless_pressed():
	AudioManager.play_sound("select.wav", Settings.sfx_volume)
	Global.switch_scene("Levels/PibbaTest.tscn")


func _on_Quit_pressed():
	get_tree().quit()
