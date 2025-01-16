extends MarginContainer

@export var text = ""
@export var ip = ""
@export var port = ""

func _ready():
	$HBoxContainer2/Label.text = text
