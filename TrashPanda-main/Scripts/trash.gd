extends Area2D

export var value = 1
export var recover = 100

var touched : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.







func _on_trash_body_entered(body):
	if body.name == "Player":
		if touched == true:
			play_anim(2)
			body.collect_trash(value, recover)
			$AudioStreamPlayer.play()
			yield(get_tree().create_timer(.9), "timeout")
			play_anim(0)
			touched = false

func play_anim(movement):
	var anim = $AnimatedSprite

	if movement == 1:
		anim.play("full")
	if movement == 0:
		anim.play("empty")
	if movement == 2:
		anim.play("eating")
