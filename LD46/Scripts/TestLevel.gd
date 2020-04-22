extends Node2D

var story = [
["Pr", "Lalala, what a normal day!"],
["Pr", "How weird, an actual plant in this empty l- land."],
["Pr", "Oh my god, an earthquake!"],
["Pr", "I've fallen and I can't get up!", "Pt", "Um, You're up.", "Pr", "I just don't have a lying animation.", "Pr", "Anyway, who are you?", "Pt", "I'm a- I'm a talking plant.", "Pr", "Cool.", "Pt", "Ok, so you have to help me get out of here.", "Pt", "Bring me the minerals. See, here's Nitrogen.", "Pt", "And be quick! You have to KEEP ME ALIVE."], 
["Pr", "gam", "Pt", "ing"]]
var progress = 0
var i = 0
signal dialogue
signal customDialogue

var earthquake = false
var after_earthquake = false;
var falling = false
var fail = false
var endgame = false
var vinepos = -16


func _physics_process(delta):
	if falling:
		$TileMaps/Overworld_destroy.position.y += 1
		$TileMaps/Overworld_destroy.position.y += $Player.motion.y * delta
		$Plant.position.y += $Player.motion.y * delta
		if $Plant.position.y > 0:
			$Plant.position.y = 0;
			falling = false
			$TileMaps/Overworld_destroy.queue_free()
			$Plant/Area2D/CollisionShape2D.disabled = false;
			$Plant/Bar.visible = true;
	if $Player.position.y > -10:
		$Plant.position.y = -6
		
	if fail and Input.is_action_pressed("accept"):
		Global.switch_scene("Levels/Main Menu.tscn")
		
	if get_node("GUI").won == true:
		if $Player.position.y < -600:
			customDialogue("Congratulations! You escaped the cave")
			$Player.canMove = false;
			endgame = true
	
	if Input.is_action_pressed("accept") and endgame:
		Global.switch_scene("Levels/Main Menu.tscn")

	

func dialogue():
	$Player.motion.x = 0
	var pos = story[progress][i]
	var d = story[progress][i+1]
	if pos == "Pr":
		pos = $Player.position
	else:
		pos = $Plant.position
	get_tree().paused = true
	emit_signal("dialogue", story[progress][i], pos, d)


func customDialogue(text):
	var pos = story[progress][i]
	pos = $Player.position
	emit_signal("customDialogue", pos, text)


func _on_Dialogue_done():
	i += 2
	if (story[progress].size() > i):
		dialogue()
	else:
		i = 0
		progress +=1;
		$Player.canMove = true;
		
	if earthquake:
		earthquake()
	
	if after_earthquake:
		after_earthquake = false
		falling = true
		$Player.canMove = false

func earthquake():
	AudioManager.play("SFX/earthquake.wav", "SFX", true)
	$Player.canMove = false
	$TileMaps/EQ_Timer.start()
	$Plant.life = $Plant.maxlife
	$Plant/Timer.start()
	earthquake = false


func _on_EQ_Timer_timeout():
	after_earthquake = true
	dialogue()


func _on_Dialogue_simple_done():
	$Player.canMove = true


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		dialogue()
		$Player.canMove = true
		$Triggers/Fall.queue_free()
		AudioManager.play("Music/Someone Else.wav", "Music", true)


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		dialogue()
		$Triggers/Overworld.queue_free()


func _on_GoBack_body_entered(body):
	if body.name == "Player":
		customDialogue("Go back. The game is to the left")
		$Triggers/GoBack.queue_free()


func _on_OW_Plant_body_entered(body):
	if body.name == "Player":
		dialogue()
		$Triggers/OW_Plant.queue_free()
		earthquake = true


func _on_Plant_fail():
	customDialogue("You lost, press Space or Enter to go to the main menu.")
	fail = true
	$Player.canMove = false
	$Player.motion.x = 0


func _on_GUI_win():
	$Enemy.queue_free()
	$Enemy2.queue_free()
	$Plant.life_drain = 0
	$Plant/Timer.stop()
	var vine = preload("res://Scenes/Instances/vines.tscn").instance()
	get_parent().add_child(vine)
	vine.position.y = vinepos
	vine.position.x = 0
	vinepos -= 16
	vine.playing = true
	$WinTimer.start()


func _on_WinTimer_timeout():
	var vine = preload("res://Scenes/Instances/vines.tscn").instance()
	get_parent().add_child(vine)
	vine.position.y = vinepos
	vine.position.x = 0
	vine.playing = true
	vinepos -= 16
