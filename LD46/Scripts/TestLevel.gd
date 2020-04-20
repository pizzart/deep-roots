extends Node2D

var story = [
["Pr", "lalala, what a normal day"],
["Pr", "How weird, an actual plant in this empty le- land"],
["Pr", "I've fallen and I can't get up!", "Pt", "You're up", "Pr", "I don't have a lying animation", "Pr", "Anyway, who are you?", "Pt", "I'm a- I'm a talking plant", "Pr", "cool", "Pt", "Ok so you have to help me get out of here", "Pt", "Bring me the minerals, see, here's Nitrogen", "Pt", "And be quick! You have to KEEP ME ALIVE "], 
["Pr", "gam", "Pt", "ing"]]
var progress = 0;
var i = 0;
signal dialogue
signal customDialogue

var earthquake = false

func dialogue():
	$Player.motion.x = 0
	var pos = story[progress][i]
	var d = story[progress][i+1]
	if (pos == "Pr"):
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
	if (story[0].size() > i):
		dialogue()
	else:
		i = 0
		progress +=1;
		$Player.canMove = true;
		
	if (earthquake):
		earthquake()
		

func earthquake():
	


func _on_Dialogue_simple_done():
	$Player.canMove = true;


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print_debug('pause')
		dialogue()
		$Player.canMove = true;
		$Area2D.queue_free()
		AudioManager.play("Music/Someone Else.wav", 0.01, true, "MUSIC")


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


