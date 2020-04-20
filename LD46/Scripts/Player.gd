extends KinematicBody2D

export var SPEED = 50
export var SPEED_LIMIT = 120
export var GRAVITY = 1000
export var JUMP_SPEED = 160

const WORLD_LIMIT = 3000
const UP = Vector2(0, -1)
var motion = Vector2(0, 0)

var canMove = true
var canJump = true
var canDash = true
var isDashing = false

var health = 2
var minerals = 0
var endless_opened = false
var high_score = 0

signal animate
signal dialogue

func _physics_process(delta):
	fall(delta)
	if canMove:
		run(delta)
		jump()
		dash()
	move_and_slide(motion, UP)
	animate()
	die()
	get_node("../GUI").minerals = minerals;


func fall(delta):
	if position.y > WORLD_LIMIT:
		die()
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
		
	if Input.is_action_pressed("jump") and !is_on_floor() and !canJump and motion.y < 0:
		motion.y -= 19 * abs(motion.y) * 0.005
		
	if Input.is_action_pressed("down") and !is_on_floor():
		motion.y += 20
		motion.x *= 0.25


func dash():
	if Input.is_action_pressed("dash") and (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and canDash:
		isDashing = true
		$CollisionShape2D.scale.y = 0.8
		if $DashCoolDown.is_stopped():
			$DashCoolDown.start(0.3)
			$ParticlesDash.start()
			
		if (Input.is_action_pressed("left") and Input.is_action_pressed("right")):
			_on_DashCoolDown_timeout()
			$DashCoolDown.start(1)
			
		if (is_on_wall()):
			_on_DashCoolDown_timeout()
			$DashCoolDown.start(1)
		
		motion.x = 0
		motion.y = 0
		if Input.is_action_pressed("left"):
			motion.x = -270
		elif Input.is_action_pressed("right"):
			motion.x = 270


func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent": get_parent().get_path(),
		"pos.x": position.x,
		"pos.y": position.y,
		"endless_enabled": endless_opened,
		"high_score": high_score
		}
	return save_dict


func _on_DashCoolDown_timeout():
	if canDash == true:
		canDash = false
		$ParticlesDash.stop()
		$DashCoolDown.start(1)
	else:
		$CollisionShape2D.scale.y = 1
		canDash = true
	
	
func _on_ParticlesDash_timeout():
	var particles = preload("res://Particles/DashParticles.tscn").instance();
	get_parent().add_child(particles);
	particles.position = position;
	particles.emitting = true;
	$CollisionShape2D.scale.y = 1
	if Input.is_action_pressed("left"):
		particles.rotation_degrees = 180.0;
	else:
		particles.rotation = 0;


func die():
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if(get_slide_collision(i).collider.is_in_group("Death")):
				position.x = 0
				position.y = -16

func animate():
	emit_signal("animate", motion, is_on_floor())
	
func dialogue(ch):
	emit_signal("dialogue", "Player", "ch")

func _on_TestLevel_dialogue(ch, d):
	if ch == "Player":
		dialogue(ch);
