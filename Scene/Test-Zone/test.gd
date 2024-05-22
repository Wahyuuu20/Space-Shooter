extends CharacterBody2D
class_name test

var rot : float = -90
var rotSpeed = 10

func _physics_process(delta):
	
#	if Input.is_action_pressed("left"):
#		var tween = create_tween()
#	#	$Sprite2D.global_rotation = lerp(0,90,1.0)
#		#$Sprite2D.look_at(Vector2(1,1))
#		print(rotate)
#		tween.tween_property($Sprite2D, "rotation_degrees", 90, 2)
#
#	if Input.is_action_pressed("Right"):
#		var tween = create_tween()
#		tween.tween_property($Sprite2D, "rotation_degrees", -90, 3)
#
#	if Input.is_action_pressed("Up"):
#		var tween = create_tween()
#		tween.tween_property($Sprite2D, "rotation_degrees", -180, 4)
#
#	if Input.is_action_pressed("Down"):
#		var tween = create_tween()
#		tween.tween_property($Sprite2D, "rotation_degrees", 0, 5)
	
	var tween = create_tween()
	var direction:Vector2 = Input.get_vector("left","Right","Up","Down")
	tween.tween_property($Sprite2D, "rotation_degrees", direction, 1)
