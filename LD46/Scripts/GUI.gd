extends CanvasLayer

var minerals;

func _physics_process(delta):
	$GUI/Minerals/HBoxContainer/MineralsNum.text = minerals;
