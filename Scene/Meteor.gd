extends CharacterBody2D


var health :int
var movedirection : Vector2
var speed:float = 500
var wandertime:float
var randomscale:Vector2



func _ready():
	health=1
	$Timer.start(wandertime)
	Random()


func _physics_process(delta):
	move_and_slide()  
	if $Timer.is_stopped():
		Random()
		$Timer.start(wandertime)

	self.velocity = movedirection * speed * delta
	

func Random():
	movedirection = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wandertime = randf_range(5,10)


func Damage(value:int):
	health-=value
	if health <= 0:
		
		queue_free()
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
