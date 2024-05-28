extends Node
class_name FiniteStateMachine

@export var state : State

func _ready():
	Change_State(state)
	
func Change_State(new_state: State):
	if state is State:
		state.Exit_State()
	new_state.Enter_State()
	state = new_state	
