extends CharacterBody2D
class_name Enemy3

@export var max_speed = 40.0
@export var acceleration = 50.0

@onready var ray_cast = $RayCast2D


func _physics_process(delta):
	ray_cast.target_position = get_local_mouse_position()
