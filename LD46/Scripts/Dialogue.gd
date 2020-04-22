extends Node2D

signal simple_done
signal done
var i = 0
var skip = true
var ongoing = false
var add = true
var text = ""
var displayText = ""
var character = ""
var sound = "SFX/voice1.wav"

func _on_TestLevel_dialogue(ch, pos, input):
	skip = false
	$Label.text = ""
	add = true
	ongoing = true
	character = ch
	if ch == "Pr":
		$Label.set("custom_colors/font_color", Color(1, 1, 1))
		sound = "SFX/voice1.wav"
	elif ch == "Pt":
		$Label.set("custom_colors/font_color", Color(153/255, 255/255, 102/255))
		sound = "SFX/voice2.wav"
	position = pos
	$Timer.start()
	text = input

func _on_TestLevel_customDialogue(pos, ntext):
	skip = false
	$Label.text = ""
	add = false
	ongoing = true
	character = "Pr"
	$Label.set("custom_colors/font_color", Color(255/255, 255/255, 102/255))
	sound = "SFX/voice1.wav"
	position = pos
	$Timer.start()
	text = ntext



func _physics_process(_delta):
	if Input.is_action_just_pressed("accept") and skip and ongoing:
		skip = false
		get_tree().paused = false
		$Label.text = ""
		if add == true:
			done()
		else:
			simple_done()


func _on_Timer_timeout():
	if i < text.length():
		ongoing = true
		displayText = str(displayText, text[i])
		$Label.text = displayText
		AudioManager.play(sound, "SFX", true, 1.0, 0.01)
		i+=1
	else:
		skip = true
		$Timer.stop()
		i = 0
		displayText = ""


func done():
	emit_signal("done")
	ongoing = false


func simple_done():
	emit_signal("simple_done")
	ongoing = false
