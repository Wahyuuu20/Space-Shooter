extends Node2D

@onready var TimerNode = $Timer

func Start_Dash(Duration):
	TimerNode.wait_time = Duration
	TimerNode.start()
	
	
# Selama Dash	
func is_Dash():	
	!TimerNode.is_stopped()
