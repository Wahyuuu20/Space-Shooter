extends CharacterBody2D
class_name Enemy4

@onready var raycast = $Raycast/RayCast2D
@onready var healthbar = $Healthbar_enemy

var movedirection : Vector2
var speed : float = 100
var speedChase : float = 150
var wandertime : float
var health : int
var player
var state = idle
var enamy3

enum{
	idle,
	chase,
	shoot,

}

func _ready():
	health = 100
	healthbar.init_health(health)
	
	#Start Random
	$Timer.start(wandertime)
	random()

func _process(delta:float):
	move_and_slide()
	
	if $Timer.is_stopped():
		random()
		$Timer.start(wandertime)
		

		
	match state:
		idle:
			self.velocity = movedirection * 1000 * delta
			RotaionDirectionIdle(delta)
			move_and_slide()
			
		
		chase:	
			position += (global.player_pos - position)/speed
			RotaionDirectionPlayer(delta)
			
		shoot:
			loadeprojectilenemy()	
		
	
func random():
	movedirection = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wandertime = randf_range(1,3)

func Damage(value:int):
	health -= value
	if health < 1:
		queue_free()
		
	healthbar.health = health

func loadeprojectilenemy():
	pass	


func RotaionDirectionPlayer(delta):
	if player:
		var rotationSpeed = 20
		var dir = (player.global_position - global_position)
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))
	
		
	if player == null:
		var rotationSpeed = 10
		var dir = movedirection
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))		
	

func RotaionDirectionIdle(delta):
	var rotationSpeed = 10
	var dir = movedirection
	var angel = self.transform.x.angle_to(dir)
	self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))   
		


func _on_first_detection_body_entered(body):
	print(body)
	player = body
	if body == player:
		state = chase
	if body == self:
		state = idle


func _on_first_detection_body_exited(body):
	player = null
	enamy3 = null
	if body != player:
		state = idle



func _on_second_detection_body_entered(body):
	pass # Replace with function body.


func _on_second_detection_body_exited(body):
	pass # Replace with function body.
