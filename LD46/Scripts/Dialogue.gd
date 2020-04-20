extends Node2D

var rng = RandomNumberGenerator.new()

var i = 0;
var skip = true
var ongoing = false;
var text = ""
var displayText = "";
var character = "";
var sound = "SFX/voice1.wav";

var random = rng.randi_range(0.5, 1.5)

signal done

func _on_TestLevel_dialogue(ch, pos, input):
	print_debug(ch, pos, input)
	ongoing = true
	character = ch;
	if ch == "Pr":
		$Label.set("custom_colors/font_color", Color(1, 1, 1))
		sound = "SFX/voice1.wav"
	elif ch == "Pt":
		$Label.set("custom_colors/font_color", Color(153/255, 255/255, 102/255))
		sound = "SFX/voice2.wav"
	position = pos;
	$Timer.start();
	text = input;


func _physics_process(delta):
	if Input.is_action_just_pressed("accept") and skip and ongoing:
		skip = false
		get_tree().paused = false
		$Label.text = ""
		done()
	else:
		skip = true


func _on_Timer_timeout():
	if (i < text.length() ):
		ongoing = true
		displayText = str(displayText, text[i])
		$Label.text = displayText;
		AudioManager.play(sound, 3, true, "SFX")
		rng.randomize();
#		$AudioStreamPlayer2D.pitch_scale = random
#		$AudioStreamPlayer2D.play();
		i+=1;
#		print_debug(text + "  " + displayText + "  " + str(i))
	else:
		$Timer.stop();
		i = 0;
		displayText = "";
		
		

func done():
	emit_signal("done")
	ongoing = false
