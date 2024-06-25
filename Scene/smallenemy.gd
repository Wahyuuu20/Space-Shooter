extends CharacterBody2D

var movespeed = 10
var player
var health

func _ready():
	health = 1

func _physics_process(_delta):
	position += (global.player_pos - global_position)/movespeed
	move_and_slide()
	look_at(global.player_pos)
	
func Damage(value:int):
	health -= value
	if health <= 0:
		queue_free()
