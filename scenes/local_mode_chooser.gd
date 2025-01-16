extends Control

func _on_backtomain_pressed():
	Transitioner.fadeTransition(load("res://scenes/mainmenu.tscn"))


func _on_duos_pressed():
	Transitioner.fadeTransition(load("res://scenes/local_menu.tscn"))
