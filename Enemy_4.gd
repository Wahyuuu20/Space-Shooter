extends CharacterBody2D
class_name Enemy4

@onready var enemy_projectile = preload("res://Scene/ProjcetileEnemy/ProjectileEnemy_3.tscn")
@onready var gunpoint = get_node("Projectile")
@onready var raycast = $Raycast/RayCast2D
@onready var healthbar = $Healthbar_enemy
@onready var timer = $TimerDelayFire

var movedirection : Vector2
var speed : float = 100
var speedChase : float = 150
var wandertime : float
var health : int
var player
var state = idle
var enamy3
var firedelay:float=0.1

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
		
	if raycast.is_colliding() and timer.is_stopped():
		timer.start(firedelay)
		loadprojectileenmey()
		
	match state:
		idle:
			self.velocity = movedirection * 1000 * delta
			RotaionDirectionIdle(delta)
			move_and_slide()
			
		
		chase:	
			position += (global.player_pos - position)/speed
			RotaionDirectionPlayer(delta)
			
		
	
func random():
	movedirection = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wandertime = randf_range(1,3)

func Damage(value:int):
	health -= value
	if health < 1:
		queue_free()
		
	healthbar.health = health

func loadprojectileenmey():	
	for child in gunpoint.get_children():
			var projectileweapon = enemy_projectile.instantiate()	
			projectileweapon.global_position = child.global_position
			projectileweapon.global_rotation = global_rotation	
			get_tree().current_scene.add_child(projectileweapon)


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

