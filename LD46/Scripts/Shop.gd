extends Node

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.minerals >= 1500:
			body.minerals -= 1500
			body.max_health += 1
			body.health += 1
			$Extra_health.texture = load("res://GFX/Static/health_no.png")
			$Extra_health/Area2D.queue_free()
