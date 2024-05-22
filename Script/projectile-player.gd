extends Area2D


var speedProjectile : float = 1000
var direction := Vector2(0,-1)

func _physics_process(delta):
	global_position += direction.rotated(rotation) * speedProjectile * delta
	
func Projectile_screen_exited():
	queue_free()

func Projectile_entered(area):
	if area.is_in_group("Damageable"):
		area.Damage(1)
		

func Projectile_Entered(body):
	if body.is_in_group("Damageable"):
		body.Damage(1)
