extends Node

@export var intitial_state : State
var state : Dictionary = {}
var current_state : State

func _ready():
	for child in get_children():
		if child is State:
			state[child.name.to_lower()] = child
			child.change_state.connect(on_child_change_state)
			
		if intitial_state:
			intitial_state.Enter()
			current_state = intitial_state
		
			
func _process(delta):
	if current_state :
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
		
func on_child_change_state(state, new_state_name):
#	print(state," ",new_state_name)
	if state != current_state:
#		print("not_current_state")
		return
		
	var new_state = state.get(new_state_name.to_lower())
	if	!new_state:
#		print("not_new_state")		
		return
	
	if current_state:
#		print("current_state")		
		current_state.Exit()
						
	new_state.Enter()
	
	current_state = new_state				
