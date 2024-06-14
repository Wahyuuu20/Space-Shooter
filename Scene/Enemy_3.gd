extends CharacterBody2D
class_name Enemy3

@onready var raycast = $RayCast2D
@onready var healthbar = $Healthbar_enemy


var player = null
var movedirection : Vector2
var speed:float = 100
var wandertime : float
var state = idle
var health : int
var speedchase :float= 50

enum {
	idle,
	chase,
	shoot,
	example
}

func _ready():
	health = 100
	healthbar.init_health(health)
	
	#Start Random
	$Timer.start(wandertime)
	random()


func _process(delta:float):
	move_and_slide()
	
	
	#Random terus menerus setiap waktu berhenti
	if $Timer.is_stopped():
		random()
		$Timer.start(wandertime)
	
#	if raycast.is_colliding():
#		print("colliding")
		
	if healthbar.health < 20:
		state = example

	
	
	
	#state machine
	match state:
		idle:
			self.velocity = movedirection * 1000 * delta
			RotaionDirectionIdle(delta)
			move_and_slide()
			
		
		chase:	
			position += (global.player_pos - position)/speed
			RotaionDirectionPlayer(delta)
			
		shoot:
			loadprojectileenmey()	
		
		example:
			healthbar.health =  100
			health = 100
			state = idle
			if player:
				state = chase
			
				
func random():
	movedirection = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()		
	wandertime = randf_range(1,3)
	
func loadprojectileenmey():	
	pass

func RotaionDirectionPlayer(delta):
	if player:
		var rotationSpeed = 20
		var dir = (player.global_position - global_position)
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))
		print("RotationChase ",dir)
		
	if player == null:
		var rotationSpeed = 10
		var dir = movedirection
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))		
		print("RotationIdle ",dir)
		
func RotaionDirectionIdle(delta):
		var rotationSpeed = 10
		var dir = movedirection
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))		
		print("RotationIdle ",dir)

func Damage(value:int):
	health -= value
	if value:
		global.player_pos = global_position
		speed = speedchase
		state = chase
		
		
	if health < 0:
		queue_free()
	healthbar.health = health	
		


func _on_area_2d_body_entered(body):
	player = body
	print(body)
	if body == player:
		state = chase
	if body == self:
		state = idle
			


func _on_area_2d_body_exited(body):
	player = null
	if body != player:
		state = idle
