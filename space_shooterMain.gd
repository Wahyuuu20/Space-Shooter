extends Node2D

@export var enemy_scene : Array[PackedScene] = []
@onready var time = $TimerSpawnEnemy
@onready var enemy_container = $EnemyContainer



func _on_timer_spawn_enemy_timeout():
	var e = enemy_scene.pick_random().instantiate()
	e.global_position = Vector2(randf_range(194,4407),randf_range(164,2185)) 
	enemy_container.add_child(e)
	
