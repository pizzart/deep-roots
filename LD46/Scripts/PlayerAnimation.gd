extends AnimatedSprite

func _ready():
	pass


func _on_Player_animate(motion, is_on_floor):
	if motion.y < -0.1:
		play("jump")
		if Input.is_action_pressed("right"):
			flip_h = true
		if Input.is_action_pressed("left"):
			flip_h = false
	elif motion.y > 1 and !is_on_floor:
		play("fall")
	elif Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
		play("run")
		flip_h = true
	elif Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		play("run")
		flip_h = false
	else:
		play("idle")
		
		
