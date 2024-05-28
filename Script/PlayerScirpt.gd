extends CharacterBody2D

#Preload Projectile
var PlProjcetilePlayer = preload("res://Scene/Projectile/projectile_player.tscn")

@onready var Healthbar = $PlayerUi/PlayerBar/Healthbar_Player
@onready var Energybar = $PlayerUi/PlayerBar/Energy

#Node Timer	
@onready var timer = $Timer

#Node Gun 


# Var Player
@export var Speed : float = 250
@export var accel: float = 60
@export var BoostSpeed : float = 500
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
	#Animate Damage Player
	
	#Print
	#print(global.player_pos)
#	print(velocity)
#	print(rotation)
	
	
	#Movement
	Movement(delta)
	
	#Movement Boost
	Boost()
	
	#GUN
	#GunPressed()
	
	#Aim
	#GunRotation()
	
	#Dash
	Dash()
	
	#RegenEnergy
	RegenEnergy(delta)
	
	
	

	
	#smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
	#$Gun.look_at(smooth_Mouse_pos)
	
#Damage	
func Damage(values):
	health -= values
	if health < 1:
		Death()
	Healthbar.health = health
	
func decreaseStamina(values: float):
	energy -= values
	Energybar.energy = energy
			

func RegenEnergy(delta):
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

# DeleteNode			
func DeleteNode():
	queue_free()		

#Movement
func Movement(delta):

	var direction:Vector2 = Input.get_vector("left","Right","Up","Down").normalized()
	velocity.x = move_toward(velocity.x,Speed * direction.x ,accel)
	velocity.y = move_toward(velocity.y,Speed * direction.y ,accel)
	
	rotation = lerp_angle(rotation, atan2(direction.x, -direction.y),delta * 5)

	var tween = create_tween()
	tween.tween_property($AtributPlayerSprite/AnimatePlayer, "rotation_degrees", rotation, 1)
	if !Input.get_vector("left","Right","Up","Down"):
		pass
	
	
#
#
	move_and_slide()
	global.player_pos = global_position
	
	
	
#func GunRotation():
	#$PlayerSprite/Gun/GunRight.look_at(get_global_mouse_position())
	#$PlayerSprite/Gun/GunLeft.look_at(get_global_mouse_position())
	
	
# Gun				
func GunPressed():
	pass
#	if Input.is_action_pressed("Primary")and NodeTimerFireRate.is_stopped():
#		NodeTimerFireRate.start(TimeFireRate)
#		AnimateProjectileGunLeft()
#		AnimateProjectileGunRight()	
#
#	if Input.is_action_pressed("Aim"):
#		pass
#		$PlayerSprite/Gun/GunRight.look_at(get_global_mouse_position())

# Gun Left	
func AnimateProjectileGunLeft():
		pass
#		var ProjcetileL = PlProjcetilePlayer.instantiate()
#		ProjcetileL.global_position = GunRayLeft.global_position
#		ProjcetileL.rotation = rotation
#		get_tree().current_scene.add_child(ProjcetileL)
		
		
# Gun Right	
func AnimateProjectileGunRight():
		pass
#		var ProjcetileR = PlProjcetilePlayer.instantiate()
#		ProjcetileR.global_position = GunRayRight.global_position
#		ProjcetileR.rotation = rotation
#		get_tree().current_scene.add_child(ProjcetileR)
	
	
#Aim
func AimPlayer():
	if Input.is_action_pressed("Aim"):
		smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
		
		
		
		
	
#MovementBoost
func Boost():
	#Movement Boost
		var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
		if Input.is_action_pressed("Boost"):
				vel.x = move_toward(velocity.x,BoostSpeed * directionBoost.x ,AccelBoost)	
				vel.y = move_toward(velocity.y,BoostSpeed * directionBoost.y ,AccelBoost)
				decreaseStamina(0.2)
				
				

#Dash		
func Dash():
	#Movemnet Dash
		var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
		if Input.is_action_just_pressed("Dash"):
				velocity.x = DashSpeed * 2 * directionBoost.x 
				velocity.y = DashSpeed * 2 * directionBoost.y
				decreaseStamina(3)
				
				
				
