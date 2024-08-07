extends CharacterBody2D
class_name Player

signal  Killed

#Preload Projectil
@onready var Healthbar = $PlayerUi/PlayerBar/Healthbar_Player
@onready var Energybar = $PlayerUi/PlayerBar/Energy

#Node Timer	
@onready var timer = $Timer

#Node Gun 


# Var Player
@export var Speed : float = 250
@export var accel: float = 60
@export var BoostSpeed : float = 100
@export var AccelBoost : float = 120
@export var DashSpeed : float = 1000
@export var timerCount = 1
var smooth_Mouse_pos : Vector2
var TimeFireRate :float = 0.2
var health
var energy
var regenEnergy
var vel := Vector2(0,0)



func _ready():
	energy = 100
	health = 100
	regenEnergy = 0.05
	Healthbar.init_health(health)
	Energybar.init_energy(energy)
	
	
	
func _process(delta):

	#Movement
	Movement(delta)
	
	#Dash
	Dash()
	
	#RegenEnergy
	RegenStamina(delta)
	
#Damage	
func Damage(values):
	health -= values
	if health <= 0:
		Killed.emit()
		Death()
	Healthbar.health = health
	
func decreaseStamina(values: float):
	energy -= values
	Energybar.energy = energy
			

func RegenStamina(delta):
	Energybar.energy = energy
	if energy < 100:
		energy = energy + regenEnergy + delta
		if energy > 100:
			energy = 100
	if energy <= 0:
		energy = 0	

#Player Death		
func Death():
	queue_free()		
	

#Movement
func Movement(delta):
	var direction:Vector2 = Input.get_vector("left","Right","Up","Down").normalized()
	velocity.x = move_toward(velocity.x,Speed * direction.x ,accel)
	velocity.y = move_toward(velocity.y,Speed * direction.y ,accel)
	
	var target_rotation = atan2(direction.x, -direction.y)
	rotation = lerp_angle(rotation, target_rotation ,delta * 5)


	move_and_slide()
	global.player_pos = global_position

	
func Dash():
	#Movemnet Dash
		var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
		if Input.is_action_just_pressed("Dash"):
				velocity.x = DashSpeed * 2 * directionBoost.x 
				velocity.y = DashSpeed * 2 * directionBoost.y
				decreaseStamina(3)
