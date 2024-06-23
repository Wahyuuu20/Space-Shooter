extends Control

@onready var scorelabel  = $Label
var score = 0

func _process(delta):
	scorelabel.text = "Score : %d" % global.score
	
