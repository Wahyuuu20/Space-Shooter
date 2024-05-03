extends ProgressBar

@onready var damageBar = $Damage_Bar
@onready var timer = $Timer

var health = 0 : set = set_health

func set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health		
	
func init_health(_health):
	health = _health
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value	= health
		

func _on_timer_timeout():
	damageBar.value = health
