extends CharacterBody2D



var MovementSpeed : float = 100

func _process(delta):
	
	#Movement
	if Input.is_action_pressed("left"):
		position.x -= MovementSpeed
	if Input.is_action_pressed("Right"):
		position.x += MovementSpeed
		
		
		
	#GUN
	Gun()	
		

func Gun():
	if Input.is_action_just_pressed("Primary"):
		print("Primary")
	if Input.is_action_just_pressed("Secondary"):
		print("Secondary")			
