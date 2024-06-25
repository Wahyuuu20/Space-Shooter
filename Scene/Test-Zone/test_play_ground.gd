extends Node2D
var player = null
@onready var gos = $CanvasLayer/GameOverScreen
@onready var audio_player_gameover = $CanvasLayer/GameOverScreen/AudioStreamPlayer
@onready var audio_player_level = $AudioStreamPlayer

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.Killed.connect(test)
	audio_player_gameover.stop()
	audio_player_level.play()
	
func test():
	audio_player_level.stop()	
	await get_tree().create_timer(0.1).timeout
	gos.visible = true
	audio_player_gameover.play()
	
		
