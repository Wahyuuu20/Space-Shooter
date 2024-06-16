extends CharacterBody2D

var movespeed = 100
var player

func _physics_process(delta):
	position += (global.player_pos - position)/movespeed
	move_and_slide()
	RotaionDirectionPlayer(delta)
	
func RotaionDirectionPlayer(delta):
		var rotationSpeed = 20
		var dir = global.player_pos
		var angel = self.transform.x.angle_to(dir)
		self.rotate(sign(angel)* min(delta*rotationSpeed, abs(angel)))	
