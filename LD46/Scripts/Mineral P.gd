extends Node2D

export var value = 750;
var current = value;


func _ready():
	AudioManager.play("SFX/pickup_appear.wav")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.minerals += current;
	
		current = 0;
		$Timer.start();
		$AnimatedSprite.visible = false;
	
func _on_Timer_timeout():
	current = value;
	$AnimatedSprite.visible = true;
	$AudioStreamPlayer2D.play();
