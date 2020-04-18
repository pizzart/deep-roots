extends Node2D

func _ready():
	#$Spikes1.visible = true
	pass
	
func _physics_process(delta):
	if ($Player.position.x < -50):
		$Spikes1.visible = true



