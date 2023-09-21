extends KinematicBody2D

var score : int =0
var maxScore : int = 3
var health : int = 100
var maxHealth : int = 100
var phazeTime : int = 0

var time : int =1

const GRAVITY = 1300.0
const wSpeed = 300.0
const JUMP = 500.0
const accel = 20
const stunJump = 250

var current_animation = "none"

var ability : bool = false
var hitted : bool = false

onready var ui = get_node("/root/MainScene/CanvasLayer/UI")


var velocity = Vector2()

func _ready():
	ui.set_score_text(score)

func _process(delta):
	print(health)
	if health <= 0:
		dead()
	if health > maxHealth:
		health = maxHealth
	
	if score>maxScore:
		score = maxScore
	
	if ability == true:
		if phazeTime == 3:
			ability = false
			phazeTime = 0
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	
	var motion = velocity * delta
	if hitted==false:
		if Input.is_action_pressed("ui_right"):
			velocity.x = min(velocity.x + accel, wSpeed)
			
			if ability == false:
				play_anim(1)
			elif ability == true:
				play_anim(5)
		elif Input.is_action_pressed("ui_left"):
			velocity.x = max(velocity.x - accel, -wSpeed)
			
			if ability == false:
				play_anim(1)
			elif ability == true:
				play_anim(5)
		else:
			if ability == false:
				play_anim(0)
				if is_on_floor()==false:
					play_anim(1)
			elif ability == true:
				play_anim(6)
				if is_on_floor()==false:
					play_anim(5)
			
			if velocity.x > (accel-1):
				velocity.x -= accel
			elif velocity.x < -(accel-1):
				velocity.x += accel
			else:
				velocity.x = 0
			
			
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = -JUMP
		if score > 0:
			if ability == false:
				if Input.is_action_just_pressed("ui_select"):
					ability = true
					score -= 1
					ui.set_score_text(score)
			
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
	if hitted ==false:
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite.flip_h = true
	
	if position.y > 700:
		dead()
	
func hit(damage):
	if ability == false:
		hitted = true
		health -= damage
	
		if health <= 0:
			dead()
		elif health >0:
			stun()
		ui.update_health(health)

func stun():
	velocity.y=-stunJump
	velocity.x=-wSpeed
	play_anim(2)
	yield(get_tree().create_timer(.6), "timeout")
	hitted = false

func dead():
	hitted = true
	velocity.x = 0
	play_anim(3)
	yield(get_tree().create_timer(.8), "timeout")
	health = 3
	get_tree().change_scene("res://Scenes/GameOverScreen.tscn")

func collect_trash(value, recover):
	hitted = true
	play_anim(4)
	score+= value
	health += recover
	velocity.x = 0
	velocity.y = 0
	yield(get_tree().create_timer(.9), "timeout")
	ability = false
	hitted = false
	
	ui.set_score_text(score)

func play_anim(movement):
	
	var anim = $AnimatedSprite
	
	if movement == 1:
		anim.play("run")
	elif movement == 0:
		anim.play("1idle")
	if movement == 2:
		anim.play("hurt")
	if movement == 3:
		anim.play("faint")
	if movement == 4:
		anim.play("invisible")
	if movement == 5:
		anim.play("Phaze_run")
	if movement == 6:
		anim.play("Phaze_idle")




func _on_healthtimer_timeout():
	if ability == false:
		if health > 0 and health <= maxHealth:
			health = health - 1
	ui.update_health(health)
	
	


func _on_phazeTimer_timeout():
	if ability == true:
		phazeTime = phazeTime + 1

