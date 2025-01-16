extends Control

func _on_quit_pressed():
	get_tree().quit()



func _on_local_pressed():		
	Transitioner.fadeTransition(load("res://scenes/local_mode_chooser.tscn"))


func _on_online_pressed():
	Transitioner.fadeTransition(load("res://scenes/online_chooser.tscn"))
