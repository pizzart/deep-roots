extends CanvasLayer

var old_minerals = 0;
var minerals = 0
var score = 0;
var health = 2;
var no_health = load("res://GFX/Static/health_no.png")
var yes_health = load("res://GFX/Static/health_yes.png")

var win_requirement = 20000;
var won = false

signal win

func _physics_process(delta):
	$GUI/Minerals/HBoxContainer/MineralsNum.text = str(minerals/100)
	if minerals > old_minerals:
		score += minerals - old_minerals
		old_minerals = minerals
	if minerals == 0:
		old_minerals = 0
	if health == 1:
		$GUI/Health/Health2.texture = no_health
	if health == 2:
		$GUI/Health/Health2.texture = yes_health
		$GUI/Health/Health3.texture = no_health
	if health == 3:
		$GUI/Health/Health3.texture = yes_health
		$GUI/Health/Health3.visible = true
		$GUI/Health/Health2.texture = yes_health
		
	if score >= win_requirement and !won:
		win()
		won = true
		
func win():
	emit_signal("win")


		
	get_node("GUI/ WinBar/Win/WinProgress").value = score/(win_requirement/100)
