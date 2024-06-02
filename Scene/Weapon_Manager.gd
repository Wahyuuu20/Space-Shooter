extends Node2D

@onready var animation_player = get_node("Weapon_Rig/AnimationPlayer")
@onready var gunpoint = get_node("Weapon_Rig/GunPoint")

var current_weapon = null
var weapon_stack = []
var weapon_indicator = 0
var next_weapon: String
var weapon_list = {}
var test = false
@export var _weapon_resources : Array[Weapon_Resource]
@export var start_weapons: Array[String]

func _ready():
	Initialize(start_weapons)
	
func _input(event):
	if event.is_action_pressed("Weapon_2"):
		weapon_indicator = min(weapon_indicator+1, weapon_stack.size()-1)
		Exit(weapon_stack[weapon_indicator])
		
	if event.is_action_pressed("Weapon_1"):
		weapon_indicator = max(weapon_indicator-1,0)
		Exit(weapon_stack[weapon_indicator])
	
	if event.is_action("Primary"):
		Shoot_and_Load_Projectile()	
				
func Initialize(_start_weapons: Array):
	for weapon in _weapon_resources:
		weapon_list[weapon.weapon_name] = weapon
	for i in _start_weapons:
		weapon_stack.push_back(i)
	current_weapon = weapon_list[weapon_stack[0]]
	Enter()
		
func Enter():
	animation_player.queue(current_weapon.active_anim)
	
func Exit(_next_weapon: String):
	if _next_weapon != current_weapon.weapon_name:
		if animation_player.get_current_animation() != current_weapon.deactive_anim:
			animation_player.play(current_weapon.deactive_anim)
			next_weapon = _next_weapon
			
	
func Change_Weapon(weapon_name: String):
	current_weapon = weapon_list[weapon_name]
	next_weapon = ""
	Enter()


func Shoot_and_Load_Projectile():
	for child in gunpoint.get_children():
		var assaultprojectile = current_weapon.projectile_to_load_weapon.instantiate()	
		assaultprojectile.global_position = child.global_position
		assaultprojectile.global_rotation = global_rotation	
		get_tree().current_scene.add_child(assaultprojectile)
		assaultprojectile.Damage = current_weapon.projectile_damage
		


func _on_animation_player_animation_finished(anim_name):
	if anim_name == current_weapon.deactive_anim:
		Change_Weapon(next_weapon)














