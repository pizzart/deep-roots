extends KinematicBody2D

export var SPEED = 50
export var SPEED_LIMIT = 120
export var GRAVITY = 1000
export var JUMP_SPEED = 150

const WORLD_LIMIT = 3000
const UP = Vector2(0,-1)
var motion = Vector2(0,0)

var canJump = true


func _physics_process(delta):
	fall(delta)
	run(delta)
	jump()
	animate()
	move_and_slide(motion, UP)
	
	
signal animate

func fall(delta):
	if position.y > WORLD_LIMIT:
		end_game()
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 20
	else:
		motion.y += GRAVITY * delta
		
	
		
func run(delta):
	if Input.is_action_pressed("left"):
		motion.x -= SPEED
	if Input.is_action_pressed("right"):
		motion.x += SPEED
		
	if (!Input.is_action_pressed("left") and !Input.is_action_pressed("right")) or (Input.is_action_pressed("left") and Input.is_action_pressed("right")):
		if abs(motion.x) > 0:
			motion.x *= 0.5
#		elif motion.x < 0:
#			motion.x += 50
		
		
	if abs(motion.x) > SPEED_LIMIT and motion.x < 0:
		motion.x = -SPEED_LIMIT
	elif abs(motion.x) > SPEED_LIMIT and motion.x > 0:
		motion.x = SPEED_LIMIT
	
		
		
		
func jump():
	if !Input.is_action_pressed("jump"):
		canJump = true
	if Input.is_action_pressed("jump") and is_on_floor() and canJump:
		motion.y = -JUMP_SPEED
		canJump = false
		#$AudioStreamPlayer2D.stream = load("res://SFX/jump1.ogg")
		$AudioStreamPlayer2D.play()
		
	if Input.is_action_pressed("jump") and !is_on_floor() and !canJump and motion.y < 0:
		motion.y -= 11 * abs(motion.y) * 0.01
	
	if Input.is_action_pressed("down") and !is_on_floor():
		motion.y += 50
		
func animate():
	emit_signal("animate", motion)
	
func end_game():
	pass
	
