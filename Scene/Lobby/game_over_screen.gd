extends Control



func set_score(value):
	$Panel/SCORE.text = "Score: " + str(value)
	

func _on_retry_pressed():
	get_tree().reload_current_scene()
