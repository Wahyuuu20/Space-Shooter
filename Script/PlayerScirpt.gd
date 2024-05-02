extends CharacterBody2D

# Preload Variabel
var PlProjcetilePlayer = preload("res://Scene/Projectile/projectile_player.tscn")
var PlRedDotAim = preload("res://Scene/Gun/Red-Dot/Aim_Red-dot.tscn")
@onready var NodeTimerFireRate = $GunStartProjectile/TimerFireRate
@onready var GunNodeLeft = $GunStartProjectile/RayCastGunleft
@onready var GunNodeRight = $GunStartProjectile/RaycastGunRight
@onready var timer = $Timer

# Var Player
@export var Speed : float = 250
@export var accel: float = 60
@export var BoostSpeed : float = 500
@export var AccelBoost : float = 120
@export var DashSpeed : float = 1000
@export var timerCount = 1
var life: int  = 10
var smooth_Mouse_pos : Vector2
var TimeFireRate :float = 0.2


func _process(_delta):
	#Animate Damage Player
	
	#Print
	#print(global.player_pos)
	print(velocity.y)
	print(velocity.x)
	#print(DashSpeed)
	
	
	
	
	#Movement
	var direction:Vector2 = Input.get_vector("left","Right","Up","Down")
	velocity.x = move_toward(velocity.x,Speed * direction.x ,accel)
	velocity.y = move_toward(velocity.y,Speed * direction.y ,accel)
	move_and_slide()
	global.player_pos = global_position
	
	
	
	#Movement Boost
	Boost()
	
	#GUN
	Gun()	
	
	#Aim
	AimPlayer()
	
	#Dash
	Dash()
	
	smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
	look_at(smooth_Mouse_pos)
	
#Damage	
func Damage(values):
	life -= values
	if life < 0:
		Death()

#Player Death		
func Death():
	queue_free()		

# DeleteNode			
func DeleteNode():
	queue_free()		

# Gun				
func Gun():
	if Input.is_action_pressed("Primary"):
		AnimateProjectileGunLeft()
		
		
	if Input.is_action_pressed("Aim") and NodeTimerFireRate.is_stopped():
		NodeTimerFireRate.start(TimeFireRate)
		AnimateProjectileGunRight()		

# Gun Left	
func AnimateProjectileGunLeft():
		var ProjcetileL = PlProjcetilePlayer.instantiate()
		ProjcetileL.global_position = GunNodeLeft.global_position
		get_tree().current_scene.add_child(ProjcetileL)
		var targetL = get_global_mouse_position()
		var direction_to_mouse = ProjcetileL.global_position.direction_to(targetL).normalized()
		ProjcetileL.set_direction(direction_to_mouse)

# Gun Right	
func AnimateProjectileGunRight():
		var ProjcetileR = PlProjcetilePlayer.instantiate()
		ProjcetileR.global_position = GunNodeRight.global_position
		get_tree().current_scene.add_child(ProjcetileR)
		var targetR = get_global_mouse_position()
		var direction_to_mouseR = ProjcetileR.global_position.direction_to(targetR).normalized()
		ProjcetileR.set_direction(direction_to_mouseR)
		
		
#Aim
func AimPlayer():
	if Input.is_action_pressed("Aim"):
		smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
		look_at(smooth_Mouse_pos)
		
		
	
#MovementBoost
func Boost():
	#Movement Boost
	var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
	if Input.is_action_pressed("Boost"):
			velocity.x = move_toward(velocity.x,BoostSpeed * directionBoost.x ,AccelBoost)	
			velocity.y = move_toward(velocity.y,BoostSpeed * directionBoost.y ,AccelBoost)
			

#Dash		
func Dash():
	var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
	if Input.is_action_just_pressed("Dash"):
			velocity.x = DashSpeed * 2 * directionBoost.x 
			velocity.y = DashSpeed * 2 * directionBoost.y
			
		
		
		
