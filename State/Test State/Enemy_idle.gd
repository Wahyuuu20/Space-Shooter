extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 10.0

var move_direction : Vector2
var wander_time : float

func randomnized_Wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)

func Enter():
	randomnized_Wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomnized_Wander()

func Physics_update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
							

