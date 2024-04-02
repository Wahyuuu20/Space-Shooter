extends CharacterBody2D

# Preload Variabel
var PlProjcetilePlayer = preload("res://Scene/Projectile/projectile_player.tscn")
@onready var GunNodeLeft = $GunStartProjectile/MarkLeft
@onready var GunNodeRight = $GunStartProjectile/MarkRight

# Var Player
@export var Speed : float = 250
@export var accel: float = 60
@export var BoostSpeed : float = 800
@export var AccelBoost : float = 120
var life: int  = 10

var smooth_Mouse_pos : Vector2

func _process(delta):
	
	#Animate Damage Player
	
	
	
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
	
# Gun Right	
func AnimateProjectileGunRight():
		var ProjcetileR = PlProjcetilePlayer.instantiate()
		ProjcetileR.global_position = GunNodeRight.global_position
		get_tree().current_scene.add_child(ProjcetileR)

#MovementBoost
func Boost():
	#Movement Boost
	var direction:Vector2 = Input.get_vector("left","Right","Up","Down")	
	if Input.is_action_pressed("Boost"):
		velocity.x = move_toward(velocity.x,BoostSpeed * direction.x ,AccelBoost)	
		velocity.y = move_toward(velocity.y,BoostSpeed * direction.y ,AccelBoost)
		

func AimPlayer():
	if Input.is_action_pressed("Aim"):
		smooth_Mouse_pos = lerp(smooth_Mouse_pos,get_global_mouse_position(),0.1)
		look_at(smooth_Mouse_pos)
	
	
	
