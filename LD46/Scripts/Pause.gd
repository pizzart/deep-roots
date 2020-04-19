extends Node

var is_paused = false


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Settings.back_to = $Main


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if !is_paused:
			get_node(".").show()
			is_paused = true
		else:
			get_node(".").hide()
			is_paused = false
		get_tree().paused = is_paused


func _on_Back_To_Game_pressed():
	get_node(".").hide()
	is_paused = false
	get_tree().paused = is_paused


func _on_Settings_pressed():
	ButtonPress.press($Settings, $Main)


func _on_Exit_to_Menu_pressed():
	ButtonPress.press($Confirm, $Main)


func _on_Yes_pressed():
	Global.switch_scene("Levels/Main Menu.tscn")


func _on_No_pressed():
	ButtonPress.press($Main, $Confirm)
