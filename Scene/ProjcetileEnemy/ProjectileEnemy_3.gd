extends Area2D


@onready var bullet_effect = preload("res://Scene/Gun/BulletEffect/bullet_effect_enemy.tscn")

var Damage: int = 1
var projectile_speed : float = 1000
var direction := Vector2(1,0)

func _physics_process(delta):
		global_position += direction.rotated(rotation) * projectile_speed * delta
		

func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.Damage(Damage)
		var effect = bullet_effect.instantiate()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
