extends Area2D

export(int) var speed = 150
export(int) var moveDist = 150

onready var startX : float = position.x
onready var targetX : float = position.x + moveDist

const gravityR = 1000



var velocityR = Vector2()


func _physics_process(delta):
	velocityR.x += delta * gravityR
	position.x = move_to(position.x, targetX, speed *delta)
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDist
		else:
			targetX =startX
			
	var anim = $Rat
	anim.play("default")
	#velocityR = move_and_slide(velocityR, Vector2(0,-1))
	
func move_to(current, to, step):
	var new = current
	
	if new < to:
		new += step
		$Rat.flip_h = true
		
		if new > to:
			new = to	
	else:
		new -=step
		$Rat.flip_h = false
		if new<to:
			new = to
		
	return new
	
func _ready():
	pass




func _on_rat_body_entered(body):
	if body.name == "Player":
		body.hit(15)
		$AudioStreamPlayer.play()
	pass # Replace with function body.

