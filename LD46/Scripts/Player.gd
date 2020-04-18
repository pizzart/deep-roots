extends KinematicBody2D

export var SPEED = 50
export var SPEED_LIMIT = 120
export var GRAVITY = 1000
export var JUMP_SPEED = 160

const WORLD_LIMIT = 3000
const UP = Vector2(0,-1)
var motion = Vector2(0,0)

var canJump = true
var canDash = true
var isDashing = false


func _physics_process(delta):
	fall(delta)
	run(delta)
	jump()
	animate()
	dash()
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
		if motion.y >= GRAVITY * 2:
			motion.y = GRAVITY * 2
		
	
		
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
		motion.y -= 19 * abs(motion.y) * 0.005
		
	if Input.is_action_pressed("down") and !is_on_floor():
		motion.y += 50
		motion.x *= 0.25
		
		
func dash():
	if Input.is_action_pressed("dash") and canDash:
		isDashing = true
		$DashParticles.set_emitting(1)
		if $DashCoolDown.is_stopped():
			$DashCoolDown.start(0.3)
		motion.x = 0
		motion.y = 0
		if Input.is_action_pressed("left"):
			motion.x = -300
		elif Input.is_action_pressed("right"):
			motion.x = 300
		
		 
	
	
	
func animate():
	emit_signal("animate", motion)
	
func end_game():
	pass
	

func _on_DashCoolDown_timeout():
	if canDash == true:
		canDash = false
		print_debug("canDash = false")
		$DashCoolDown.start(4)
	else:
		canDash = true
		print_debug("canDash = true")
	
	
	
	
