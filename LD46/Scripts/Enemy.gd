extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2(0, 0)

func _physics_process(_delta):
	var pos_x
	var motion_x
	if position.x < 0:
		$Enemy.flip_h = true
		pos_x = -3
		motion_x = 15
	elif position.x > 0:
		pos_x = 3
		motion_x = -15
	
	if abs(position.x) < 5:
		position.x = pos_x
	elif !is_on_wall():
		motion.y = 0
		motion.x = motion_x
	if is_on_wall():
		motion.y = -7
	move_and_slide(motion, UP)


func _on_Area2D_body_entered(body):
	if body.name == "Player" and body.motion.y > 17:
		if position.x >0:
			position.x += 300
		else:
			position.x -= 300
		position.y = 76
		body.motion.y = -100;
	elif body.name == "Player":
		body.health -= 1;
		
