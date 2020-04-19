extends Node2D

export var life_drain = 1;
export var win_requirement = 1000;
export var maxlife = 1000;

var life = maxlife;
var win = 0;


func _physics_process(delta):
	life -= life_drain;
	animate();
	print_debug(life)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.minerals > 0:
			life += body.minerals;


func animate():
	$Bar.frame = 14 - life/(maxlife/14)
