extends Area2D


var speedProjectile : float = 1000
var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speedProjectile * delta
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction

func Projectile_screen_exited():
	queue_free()

func Projectile_entered(area):
	if area.is_in_group("Damageable"):
		area.Damage(1)
