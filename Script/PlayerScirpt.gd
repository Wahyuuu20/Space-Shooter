extends CharacterBody2D

# Preload Variabel
var PlProjcetilePlayer = preload("res://Scene/Projectile/projectile_player.tscn")
@onready var GunNodeLeft = $GunStartProjectile/MarkLeft
@onready var GunNodeRight = $GunStartProjectile/MarkRight

# Var Player
var MovementSpeed : float = 100
var life: int  = 10

func _process(delta):
	
	#Animate Damage Player
	
	
	
	#Movement
	if Input.is_action_pressed("left"):
		position.x -= MovementSpeed
	if Input.is_action_pressed("Right"):
		position.x += MovementSpeed
		
		
		
	#GUN
	Gun()	

func Damge(values):
	life -= values
	if life < 0:
		Death()
				
func Gun():
	if Input.is_action_pressed("Primary"):
		AnimateProjectileGunLeft()
		
		
	if Input.is_action_pressed("Secondary"):
		print("Secondary")			
		
func Death():
	queue_free()		
			
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
