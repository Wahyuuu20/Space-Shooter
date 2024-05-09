extends Area2D

#Preload
@onready var GunLeft = $AtributEnemy/GunLeft
@onready var GunRight = $AtributEnemy/GunRight
@onready var GunLeftMarker = $AtributEnemy/MarkLeft
@onready var GunLeftRight = $AtributEnemy/MarkerRight
@onready var healthbar = $AtributEnemy/Healthbar_enemy
@onready var SpriteEnemy = $Sprite2D

#Variabel
var SpeedChase : float = 100
var playerChase = false
var player = false
var playerLook = false

#Health
var health : int


func _ready():
	health = 100
	healthbar.init_health(health)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Chase()
	RotaionDirectionPlayer(player, delta)
	
func Damage(value: int):
	health -= value
	if health <= 0:
		queue_free()
	healthbar.health = health

func Chase():
	if playerChase :
		position += (player.position - position)/SpeedChase
		
	
func Player_Look():
	pass
#	if playerLook:	
#		Ray.target_position = to_local(global.player_pos)
		
func RotaionDirectionPlayer(target, delta):
	if player:
		var rotationSpeed = 20
		var dir = (target.global_position - global_position)
		var angel = SpriteEnemy.transform.x.angle_to(dir)
		var angleGun = $AtributEnemy.transform.x.angle_to(dir)
		SpriteEnemy.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))
		$AtributEnemy.rotate(sign(angleGun)* min(delta*rotationSpeed, abs(angleGun)))
	


#Detection player
func Detection_player_entered(body):
	player = body
	playerChase = true
	playerLook = true


func Detection_player_exited(_body):
	player = null
	playerChase = false
	playerLook = false



#Detection Rush to Player
func Enemy_rush_entered(_body):
	pass # Replace with function body.


func Enemy_rush_exited(_body):
	pass # Replace with function body.

