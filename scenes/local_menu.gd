extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var local_address = "0.0.0.0"
	var addresses = IP.get_local_addresses()
	for each in addresses:
		if each[4] != ":" and each[1] != ":" and not each.begins_with("127.0"):
			local_address = each
	print(local_address)
	var identifier = local_address.split(".")[2]
	print(identifier)


func _on_create_pressed():
	$AnimationPlayer.play("slide")

func _on_back_pressed():
	$AnimationPlayer.play_backwards("slide")


func _on_backtomode_pressed():
	Transitioner.fadeTransition(load("res://scenes/local_mode_chooser.tscn"))
