extends State
class_name EnemyIdle

@export var enemy:CharacterBody2D
@export var move_speed := 100.00
var move_direction : Vector2
var wander_time : float
var player : CharacterBody2D

func Randmoize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	Randmoize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
		
	else:
		Randmoize_wander()		

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	print(direction)
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	if direction.length() < 90:
		change_state.emit(self, "Chase")

