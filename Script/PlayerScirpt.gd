extends CharacterBody2D

# Preload Variabel
var PlProjcetilePlayer = preload("res://Scene/Projectile/projectile_player.tscn")
var PlRedDotAim = preload("res://Scene/Gun/Red-Dot/Aim_Red-dot.tscn")
@onready var GunNodeLeft = $GunStartProjectile/RayCastGunleft
@onready var GunNodeRight = $GunStartProjectile/RaycastGunRight
@onready var RedDot = $RedDot2
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

func _process(delta):
	RedDot.hide()
	#Animate Damage Player
	
	#Print
	print(velocity.x)
	print(velocity.y)
	
	
	
	
	#Movement
	var direction:Vector2 = Input.get_vector("left","Right","Up","Down")
	velocity.x = move_toward(velocity.x,Speed * direction.x ,accel)
	velocity.y = move_toward(velocity.y,Speed * direction.y ,accel)
	move_and_slide()
	
	#Movement Boost
	Boost()
	
	#GUN
	Gun()	
	
	#Aim
	AimPlayer()
	
	#Dash
	Dash()
	
#Damage	
func Damge(values):
	life -= values
	if life < 0:
		Death()

# Gun				
func Gun():
	if Input.is_action_pressed("Primary"):
		AnimateProjectileGunLeft()
		
		
	if Input.is_action_pressed("Secondary"):
		print("Secondary")			

#Player Death		
func Death():
	queue_free()		

# DeleteNode			
func DeleteNode():
	queue_free()		

# Gun Left	
func AnimateProjectileGunLeft():
		var ProjcetileL = PlProjcetilePlayer.instantiate()
		ProjcetileL.global_position = GunNodeLeft.global_position
		get_tree().current_scene.add_child(ProjcetileL)
		var target = get_global_mouse_position()
		var direction_to_mouse = ProjcetileL.global_position.direction_to(target).normalized()
		ProjcetileL.set_direction(direction_to_mouse)

# Gun Right	
func AnimateProjectileGunRight():
		var ProjcetileR = PlProjcetilePlayer.instantiate()
		ProjcetileR.global_position = GunNodeRight.global_position
		get_tree().current_scene.add_child(ProjcetileR)

#MovementBoost
func Boost():
	#Movement Boost
	var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
	if Input.is_action_pressed("Boost"):
			velocity.x = move_toward(velocity.x,BoostSpeed * directionBoost.x ,AccelBoost)	
			velocity.y = move_toward(velocity.y,BoostSpeed * directionBoost.y ,AccelBoost)
			
#Aim		
func AimPlayer():
	if Input.is_action_pressed("Aim"):
		smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
		look_at(smooth_Mouse_pos)
		RedDot.show()

#Dash		
func Dash():
	var directionBoost:Vector2 = Input.get_vector("left","Right","Up","Down")	
	if Input.is_action_just_pressed("Dash"):
			velocity.x = DashSpeed * 2 * directionBoost.x 
			velocity.y = DashSpeed * 2 * directionBoost.y
			
		
		
		
