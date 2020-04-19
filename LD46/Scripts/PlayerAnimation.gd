extends AnimatedSprite

func _ready():
	pass


func _on_Player_animate(motion):
	if motion.y < -0.1:
		play("jump")
	elif motion.y > 0.1:
		play("fall")
	elif Input.is_action_pressed("right") and !Input.is_action_pressed("left"):
		play("run")
		flip_h = true
	elif Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		play("run")
		flip_h = false
	else:
		play("idle")
		
		
