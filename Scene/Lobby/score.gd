extends Control

@onready var score  = $Label:
	set(value):
		score.text = "Score : "+ str(value)


	
