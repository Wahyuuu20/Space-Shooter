extends Area2D


var speedProjectile : float = 20

func _process(delta):
	position.y -= speedProjectile




func Projectile_screen_exited():
	queue_free()
