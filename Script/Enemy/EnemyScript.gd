extends Area2D

#Preload 
@onready var PlProjectileTest = preload("res://Scene/Projectile/projectile_player.tscn")
@onready var DistanceDetection = $Detection/Detection_Area/CollisionShape2D
@onready var DectionPlayerTimer = $Detection/Chase/DetectionTimerPlayer
@onready var ChaseArea = $Detection/Chase
@onready var healthbar = $AtributeEnemy/Healthbar_enemy

#Variabel Enemy
var detctionTime :float = 0.5
@export var SpeedRush :float = 20
@export var SpeedChase : float = 100

#For player
var player = false
var playerChase = false
var playerRush = false	
var playerlook = false

#Health
var health : int


func _ready():
	health = 100
	healthbar.init_health(health)
	
	
func _physics_process(delta):
#	print(playerChase)
#	print(playerRush)
#	print(playerlook)
#	print(position)
	
	
	#Detect Player Raycast
	Player_Look()
	
	#Player Chase	
	Chase_Rush() #Rush
	Chase() #Chase
	
	#Rotation to Player
	RotationDirectionPlayer(player, delta)
	
	#Ray Cast colliding body
	#EnemyShoot()

#Damageable
func Damage(value: int):
	health -= value
	if health <= 0:
		queue_free()
	healthbar.health = health
		
#Player Chase Rush
func Chase_Rush():
	if playerRush and player!=null:
		position += (player.position - position)/SpeedRush
		
#Player Chase	
func Chase():
	if playerChase :
		position += (player.position - position)/SpeedChase
		
	
func Player_Look():
	pass
	#if playerlook:	
	#	Ray.target_position = to_local(global.player_pos)
		
	
func RotationDirectionPlayer(target, delta):
	if player:
		var rotationSpeed = 20
		var dir = (target.global_position - global_position)
		var angel = $SpriteEnemy.transform.x.angle_to(dir)
		var angleGun = $AtributeEnemy.transform.x.angle_to(dir)
		$SpriteEnemy.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))
		$AtributeEnemy.rotate(sign(angleGun)* min(delta*rotationSpeed, abs(angleGun)))
	

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

