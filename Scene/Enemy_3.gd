extends CharacterBody2D
class_name Enemy3

var player = null
var movedirection : Vector2
var speed:float = 100
var wandertime : float
@onready var raycast = $RayCast2D
var state = idle

enum {
	idle,
	chase,
	shoot
}

func _ready():
	$Timer.start(wandertime)
	random()


func _process(delta:float):
	move_and_slide()
	print(wandertime)
	print(movedirection)
	
	#Random terus menerus setiap waktu berhenti
	if $Timer.is_stopped():
		random()
		$Timer.start(wandertime)
	
	if raycast.is_colliding():
		print("colliding")
		
		
	
	#state machine
	match state:
		idle:
			self.velocity = movedirection * 1000 * delta
			move_and_slide()
	
			
			
		chase:	
			position += (player.position - position)/speed
			RotaionDirectionPlayer(player,delta)
			
		shoot:
			loadprojectileenmey()	
			
func random():
	movedirection = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()		
	wandertime = randf_range(1,3)
	
func loadprojectileenmey():	
	pass

func RotaionDirectionPlayer(target, delta):
	if player:
		var rotationSpeed = 20
		var dir = (target.global_position - global_position)
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))




func _on_area_2d_body_entered(body):
	player = body
	if body == player:
		state = chase
	if body == self:
		state = idle	


func _on_area_2d_body_exited(body):
	player = null
	if body != player:
		state = idle
