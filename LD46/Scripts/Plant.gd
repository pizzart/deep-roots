extends Node2D

export var life_drain = 1;
export var win_requirement = 1000;
export var maxlife = 10000;

var life = maxlife;
var win = 0;
var damage = false;

signal fail

func _physics_process(delta):
	if life > 0:
		life -= life_drain;
	if damage:
		life -= life_drain * 2;
	if life < 0:
		life = 0;
		fail()
		
	
	
	animate();
#	print_debug(life)


func fail():
	life_drain = 0
	emit_signal("fail")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.minerals > 0:
			life += body.minerals;
			body.minerals = 0;
	if body.name == "Enemy":
		damage = true;

func _on_Area2D_body_exited(body):
	if body.name == "Enemy":
		damage = false;

func animate():
	$Bar.frame = 14 - life/(maxlife/14)
	if life < maxlife/3:
		$Exclamation.visible = true;




func _on_Timer_timeout():
	life_drain+=0.5
