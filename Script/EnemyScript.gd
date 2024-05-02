extends Area2D

#Preload 
@onready var DistanceDetection = $Detection/Detection_Area/CollisionShape2D
@onready var DectionPlayerTimer = $Detection/Chase/DetectionTimerPlayer
@onready var ChaseArea = $Detection/Chase
@onready var Ray = $Detection/RayCastDetc/R1
@onready var Ray2 = $Detection/RayCastDetc/R2
@onready var Ray3 = $Detection/RayCastDetc/R3
@onready var Ray4 = $Detection/RayCastDetc/R4
@onready var Ray5 = $Detection/RayCastDetc/R5
@onready var health_bar = $Healthbar_Player

#Variabel Enemy
var player = false
var detctionTime :float = 0.5
@export var SpeedRush :float = 20
@export var SpeedChase : float = 100
var playerChase = false
var playerRush = false	
var playerlook = false
var health : int

func _ready():
	health = 100
	health_bar.init_health(health)
	
	
	
func _physics_process(_delta):
#	print(playerChase)
#	print(playerRush)
#	print(playerlook)
#	print(position)
	
	
	#Detect Player Raycast
	Player_Look()
	
	#Player Chase	
	Chase_Rush() #Rush
	Chase() #Chase

#Damageable
func Damage(value: int):
	health -= value
	if health <= 0:
		queue_free()
		
		
#Player Chase Rush
func Chase_Rush():
	if playerRush and player!=null:
		position += (player.position - position)/SpeedRush
		
#Player Chase	
func Chase():
	if playerChase :
		position += (player.position - position)/SpeedChase
		
	
func Player_Look():
	if playerlook:	
		Ray.target_position = to_local(global.player_pos)
		
	
#Detection layer 1	
# Detction Player
func Player_entered(body):
	player = body
	playerlook = true
	playerChase = true
	

# Detecition Player
func Player_exited(_body):
	player = null
	playerlook = false
	playerChase = false
	

#Detection Player 2	
# Chase Player
func Player_chase_entered(_body):
	playerRush = true
	DectionPlayerTimer.start(detctionTime)
	if DectionPlayerTimer.is_stopped():
		playerRush = true
	
#Chase Player
func Stop_Player_chase_exited(_body):
	playerRush = false	
	playerChase = false

#Check Player on detection area
func Detection_Payer_Chase_timeout():
	DectionPlayerTimer.start(detctionTime)
	if playerRush == false:
		playerRush = true
	elif playerRush == true:
		playerRush = false

