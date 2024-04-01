extends CharacterBody2D



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
	if Input.is_action_just_pressed("Primary"):
		print("Primary")
	if Input.is_action_just_pressed("Secondary"):
		print("Secondary")			
		
func Death():
	queue_free()		
			
func DeleteNode():
	queue_free()		
