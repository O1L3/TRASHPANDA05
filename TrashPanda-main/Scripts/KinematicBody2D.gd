extends KinematicBody2D

var score :	 int =0

const GRAVITY = 800.0
const wSpeed = 200.0
const JUMP = 400.0
const accel = 1000

var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	var motion = velocity * delta
	

	if Input.is_action_pressed("ui_right"):
		velocity.x = wSpeed
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -wSpeed
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
	if velocity.x > 0:
		$Birb.flip_h = true
	elif velocity.x < 0:
		$Birb.flip_h = false
		
func die():
	get_tree().reload_current_scene()

func collect_coin(value):
	score+= value



