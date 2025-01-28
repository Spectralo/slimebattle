extends MarginContainer

@export var text = ""
@export var ip = ""
@export var port = ""
@export var number = ""
@export var canBeRemoved = true

func _ready():
	$HBoxContainer2/Label.text = text
	if not canBeRemoved:
		$HBoxContainer2/Delete.queue_free()

func removeSelf():
	var config = ConfigFile.new()
	var err = config.load("user://server_config.ini")
	config.erase_section("server"+str(number))
	config.save("user://server_config.ini")
	$AnimationPlayer.play("disapear")



func _on_delete_pressed():
	removeSelf()


func _on_animation_player_animation_finished(anim_name):
	queue_free()


func _on_button_pressed():
	Transitioner.fadeTransition(load("res://scenes/lobby.tscn"))
