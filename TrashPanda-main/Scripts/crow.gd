extends Area2D

export(int) var speed = 170
export(int) var moveDist = 400

onready var startX : float = position.x 
onready var targetX : float = position.x + moveDist

func _physics_process(delta):
	position.x = move_to(position.x, targetX, speed *delta)
	
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x + moveDist
		else:
			targetX =startX
			
	var anim = $crow
	anim.play("default")
	
func move_to(current, to, step):
	var new = current
	if new < to:
		new += step
		$crow.flip_h = true
		
		if new > to:
			new = to	
	else:
		new -=step
		$crow.flip_h = false
		if new<to:
			new = to
		
	return new
	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hit(15)
		$AudioStreamPlayer.play()
	pass # Replace with function body.
