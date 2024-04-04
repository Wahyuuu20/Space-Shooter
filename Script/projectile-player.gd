extends Area2D


var speedProjectile : float = 20

func Projectile_screen_exited():
	queue_free()
