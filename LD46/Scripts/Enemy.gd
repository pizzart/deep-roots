extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2(0, 0)

func _physics_process(delta):
	if !is_on_wall():
		motion.y = 0
		motion.x = -20;
	if is_on_wall():
		print_debug('floor')
		motion.y = -20;
	move_and_slide(motion, UP)
	
