extends Area2D

var Damage: int = 0 
var projectile_speed: float = 0
var direction := Vector2(0,-1)

func _physics_process(delta):
	global_position += direction.rotated(rotation) * projectile_speed * delta


func _on_area_entered(area):
	if area.is_in_group("Damageable"):
		area.Damage(Damage)


	
func Projectile_screen_exited():
	queue_free()


