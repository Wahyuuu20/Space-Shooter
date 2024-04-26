extends Area2D

@onready var DistanceDetection = $Detection/Area2D/CollisionShape2D
@onready var Ray = $Detection/R1
@onready var Ray2 = $Detection/R2
@onready var Ray3 = $Detection/R3
@onready var Ray4 = $Detection/R4
@onready var Ray5 = $Detection/R5

var player = false
var Speed :float = 25
var player_chase = false
var player_look = false


func _physics_process(delta):
	print(player)
	print(player_chase)
	print(player_look)
	
	
	#Detect Player Raycast
	Player_Look()
	
func Player_Chase():
	if player_chase:
		position += (player.position - position)/Speed
	
func Player_Look():
	if player_look:	
		Ray.target_position = to_local(global.player_pos)
		
	

func Player_entered(body):
	player = body
	player_chase = true
	player_look = true



func Player_exited(body):
	player = null
	player_chase = false
	player_look = false
