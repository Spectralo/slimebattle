extends MarginContainer

@export var name_or_ip = "0.0.0.0"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_props(ip):
	name_or_ip = ip
	$Item/Label.text = ip

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
