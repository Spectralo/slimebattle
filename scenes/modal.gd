extends CanvasLayer
@export var Error = ""

func _ready():
	$Control/MarginContainer/VBoxContainer2/MarginContainer/Explanation.text = Error
	var lines = $Control/MarginContainer/VBoxContainer2/MarginContainer/Explanation.get_line_count()
	var lineheight = $Control/MarginContainer/VBoxContainer2/MarginContainer/Explanation.get_line_height()
	$Control/ColorRect2.size.y = 75+(lineheight*lines)
	$Control/AnimationPlayer.play("slide")


func _on_button_pressed():\
	$Control/AnimationPlayer.play("slideout")
