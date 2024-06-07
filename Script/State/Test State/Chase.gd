extends State
class_name Chase

@export var enemy: CharacterBody2D
@export var move_speed := 150.0
var player : CharacterBody2D
var player_detection = false
func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(_delta :float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 150:	
		print("test")
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	
	
