extends Node2D

@onready var animation_mobile_suit = get_node("Mobile_Suit_Rig/AnimationMobileSuit")

var current_mobile_suit = null
var mobile_suit_list = {}
var mobile_suit_stack = []
var exit_mobile_suit : String
var mobile_suit = false
var next_mobile_suit : String

@export var _mobile_suit_resource : Array[Mobile_Suit_Resource]
@export var start_mobile_suit: Array[String]

func _ready():
	Initialize(start_mobile_suit)


func _input(event):
	if event.is_action_pressed("Mobile_Suit"):
		pass


func Initialize(_start_mobile_suit):
	for mobile_suit in  _mobile_suit_resource:
		mobile_suit_list[mobile_suit.mobile_suit_name] = mobile_suit
	for i in _start_mobile_suit:
		mobile_suit_stack.push_back(i)
		current_mobile_suit = mobile_suit_list[mobile_suit_stack[0]]
		Enter()
	
func Change_Mobile_Suit(mobile_suit_name: String):
	current_mobile_suit = mobile_suit_list[mobile_suit_name]
	next_mobile_suit = ""
	Enter()
	
		
func Enter():
	animation_mobile_suit.queue(current_mobile_suit.suit_active_ani)		
	mobile_suit = true

func Exit(_next_mobile_suit: String):
	if _next_mobile_suit != current_mobile_suit.mobile_suit_name:
		if animation_mobile_suit.get_current_animation() != current_mobile_suit.suit_deactive_ani:
			animation_mobile_suit.play(current_mobile_suit.suit_deactive_ani)
			mobile_suit = false

