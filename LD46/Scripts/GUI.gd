extends CanvasLayer

var minerals = 0

func _physics_process(delta):
	$GUI/Minerals/HBoxContainer/MineralsNum.text = str(minerals)
