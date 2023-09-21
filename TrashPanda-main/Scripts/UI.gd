extends Control


onready var scoreText = get_node("ScoreText")
onready var hearts = get_node("Hearts")


func _ready():
	
	pass 




func set_score_text(score):
	
	if score == 1:
		$Phaze.visible =true
		$Phaze2.visible = false
		$Phaze3.visible = false
	elif score == 2:
		$Phaze.visible = true
		$Phaze2.visible = true
		$Phaze3.visible = false
	elif score == 3:
		$Phaze.visible = true
		$Phaze2.visible = true
		$Phaze3.visible = true
	elif score == 0:
		$Phaze.visible =false
		$Phaze2.visible = false
		$Phaze3.visible = false

func update_health(health):
	var healthbar = $healthbar
	healthbar.value = health
