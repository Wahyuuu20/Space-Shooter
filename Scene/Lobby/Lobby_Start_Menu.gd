extends Node2D



func _on_start_pressed():
	get_tree().change_scene_to_file("res://space_shooterMain.tscn")


func _on_help_pressed():
	get_tree().change_scene_to_file("res://Scene/Lobby/help_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()