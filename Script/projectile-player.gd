extends Area2D


var speedProjectile : float = 5
var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speedProjectile 
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction

func Projectile_screen_exited():
	queue_free()
