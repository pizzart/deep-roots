extends Particles2D


var i = 100;

func _physics_process(delta):
	
	i -= 1
	
	if i < 10:
		queue_free()