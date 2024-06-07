extends Node2D

@onready var animation_mobile_suit = get_node("Mobile_Suit_Rig/AnimationMobileSuit")

var current_mobile_suit = null
var mobile_suit_list = {}
var mobile_suit_stack = []
var next_mobile_suit : String
var indicator_mobile_suit = 0

@export var _mobile_suit_resource : Array[Mobile_Suit_Resource]
@export var start_mobile_suit: Array[String]

func _ready():
	Initialize(start_mobile_suit)
#	print("current Mobile suit",current_mobile_suit)
#	print("mobile Suit List",mobile_suit_list)
#	print("Mobile suit stack",mobile_suit_stack)
#	print("Indcator suit", indicator_mobile_suit)


#func _input(event):
#	if event.is_action_pressed("Mobile_Suit_2"):
#		indicator_mobile_suit = min(indicator_mobile_suit+1, mobile_suit_stack.size()-1)
#		Exit(mobile_suit_stack[indicator_mobile_suit])
#
#	if event.is_action_pressed("Mobile_Suit_1"):
#		indicator_mobile_suit = max(indicator_mobile_suit-1,0)
#		Exit(mobile_suit_stack[indicator_mobile_suit])
#

func Initialize(_start_mobile_suit: Array):
	for mobile_suit in  _mobile_suit_resource:
		mobile_suit_list[mobile_suit.mobile_suit_name] = mobile_suit
	for i in _start_mobile_suit:
		mobile_suit_stack.push_back(i)
		current_mobile_suit = mobile_suit_list[mobile_suit_stack[0]]
		Enter()
	
#func Change_Suit(mobile_suit_name: String):
#	current_mobile_suit = mobile_suit_list[mobile_suit_name]
#	next_mobile_suit = ""
#	Enter()
	
		
func Enter():
	animation_mobile_suit.queue(current_mobile_suit.animation_suit_active)		
	

func Exit(_next_mobile_suit: String):
	if _next_mobile_suit != current_mobile_suit.mobile_suit_name:
		if animation_mobile_suit.get_current_animation() != current_mobile_suit.animation_suit_deactive:
			animation_mobile_suit.play(current_mobile_suit.animation_suit_active)
		



#func _on_animation_mobile_suit_animation_finished(anim_name):
#	if anim_name == current_mobile_suit.animation_suit_active:
#		Change_Suit(next_mobile_suit)



