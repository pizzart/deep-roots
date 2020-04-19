extends Area2D

func body_entered(body):
	if body.is_in_group("Death"):
		position.x = 0
		position.y = -16
		print_debug("success")
