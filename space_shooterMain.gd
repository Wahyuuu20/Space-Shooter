extends Node2D

@export var enemy_scene : Array[PackedScene] = []

@onready var time = $TimerSpawnEnemy
@onready var enemy_container = $EnemyContainer
@onready var gos = $Hud/GameOverScreen
@onready var audio_player_level = $AudioStreamPlayer
@onready var audio_player_gameover = $Hud/GameOverScreen/AudioStreamPlayer
@onready var hud_score = $Hud/Score
var player = null
var score := 0:
	set(value):
		score = value
		hud_score.score = score

func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("Player")
	gos.visible = false
	player.Killed.connect(GameOverUi)
	audio_player_gameover.stop()
	audio_player_level.play()
	
func _physics_process(delta):	
	if time.wait_time > 0.5:
		time.wait_time -= delta * 0.05
	elif time.wait_time < 0.5:
		time.wait_time = 0.5
	
	
func GameOverUi():
	audio_player_level.stop()	
	await get_tree().create_timer(0.5).timeout
	gos.visible = true
	audio_player_gameover.play()
	gos.set_score(score)

func _on_timer_spawn_enemy_timeout():
	var e = enemy_scene.pick_random().instantiate()
	e.global_position = Vector2(randf_range(194,4407),randf_range(164,2185)) 
	e.Killed.connect(on_enemy_killed)
	enemy_container.add_child(e)
	
	
func on_enemy_killed(points):
	score += points
	
	
