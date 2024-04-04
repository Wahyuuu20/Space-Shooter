extends Node2D

@onready var TimerNode = $Timer

func Start_Boost(Duration):
	TimerNode.wait_time = Duration
	TimerNode.start()
	
	
# Selama Dash	
func is_Boost():	
	!TimerNode.is_stopped()
