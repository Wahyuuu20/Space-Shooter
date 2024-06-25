extends CharacterBody2D

signal Killed(points)

var movespeed = 10
var player
var health
@export var points = 50

func _ready():
	health = 1

func _physics_process(_delta):
	position += (global.player_pos - global_position)/movespeed
	move_and_slide()
	look_at(global.player_pos)
	
func Damage(value:int):
	health -= value
	if health <= 0:
		Killed.emit(points)
		queue_free()
