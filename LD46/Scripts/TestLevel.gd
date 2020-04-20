extends Node2D

var story = [["Pr", "hi", "Pt", "hello"], 
["Pr", "gam", "Pt", "ing"]]
var progress = 0;
var i = 0;
signal dialogue


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print_debug('pause')
		dialogue(story[progress][0], story[progress][1])
		$Player.canMove = true;
		$Area2D.queue_free()
		
		

func dialogue(pos, d):
	if (pos == "Pr"):
		pos = $Player.position
	else:
		pos = $Plant.position
	get_tree().paused = true
	emit_signal("dialogue", story[progress][i], pos, d)


func _on_Dialogue_done():
	i += 2
	if (story[0].size() > i):
		dialogue(story[progress][i], story[progress][i+1])
	else:
		i = 0
		progress +=1;
		$Player.canMove = true;
	
