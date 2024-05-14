extends ProgressBar

@onready var timer = $Timer
@onready var decrease_bar = $ProgressBar
var energy = 0 : set = _set_energy

func _set_energy(new_energy):
	var prev_energy = energy
	energy = min(max_value, new_energy)
	value = energy
	
	if energy < prev_energy:
		timer.start()
	else: 
		decrease_bar.value = energy
		
func init_energy(_energy):
	energy = _energy
	max_value = energy
	value = energy
	decrease_bar.max_value = energy
	decrease_bar.value = energy
	
			

func _on_timer_timeout():
	decrease_bar.value = energy
