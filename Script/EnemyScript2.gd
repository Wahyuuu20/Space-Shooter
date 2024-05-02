extends Area2D

#Preload
@onready var GunLeft = $Gun/GunLeft
@onready var GunRight = $Gun/GunRight
@onready var GunLeftMarker = $Gun/MarkLeft
@onready var GunLeftRight = $Gun/MarkerRight

#Variabel
var SpeedChase : float = 100
var playerChase = false
var player = false
var playerLook = false
var health : int


func _ready():
	health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Chase()

func Damage(value: int):
	health -= value
	if health <= 0:
		queue_free()


func Chase():
	if playerChase :
		position += (player.position - position)/SpeedChase
		
	
func Player_Look():
	pass
#	if playerLook:	
#		Ray.target_position = to_local(global.player_pos)
		



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

