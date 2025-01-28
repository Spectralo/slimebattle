extends Control

func _on_backtomain_pressed():
	Transitioner.fadeTransition(load("res://scenes/mainmenu.tscn"))


func _ready():
	refreshServers()

func _on_add_pressed():
	$AnimationPlayer.play("slide")


func _on_backtobasic_pressed():
	$AnimationPlayer.play_backwards("slide")
	for each in $Basic/MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer.get_children():
		each.queue_free()
	refreshServers()

func refreshServers():
	var config = ConfigFile.new()
	var err = config.load("user://server_config.ini")
	var serverCard = load("res://scenes/server_card.tscn")
	if err != OK:
		return
	for server in config.get_sections():
		if not server == "basic":
			var newServerCard = serverCard.instantiate()
			var ip = config.get_value(server,"ip")
			var port = config.get_value(server,"port")
			var number = config.get_value(server,"number")
			newServerCard.ip = ip
			newServerCard.port = port
			newServerCard.number = number
			newServerCard.text = str(ip)+":"+str(port)
			$Basic/MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer.add_child(newServerCard)

func _on_add_to_list_pressed():
	var ip = $AddServer/MarginContainer/VBoxContainer/HBoxContainer/IP.text
	var port = $AddServer/MarginContainer/VBoxContainer/HBoxContainer/PORT.text
	if is_valid_port(port) and is_valid_ip(ip):
		addServer(port,ip)
	else:
		var error_scene = load("res://scenes/modal.tscn").instantiate()
		error_scene.Error = "Enter a valid ip or port !"
		get_tree().root.add_child(error_scene)
	
func addServer(port,ip):
	var config = ConfigFile.new()
	var err = config.load("user://server_config.ini")
	var serverCard = load("res://scenes/server_card.tscn")
	var servercount = config.get_value("basic","servercount",0)
	config.set_value("server"+str(servercount+1),"ip",ip)
	config.set_value("server"+str(servercount+1),"port",port)
	config.set_value("server"+str(servercount+1),"number",servercount+1)
	config.set_value("basic","servercount",servercount+1)
	config.save("user://server_config.ini")
	refreshServers()
	$AnimationPlayer.play_backwards("slide")
	
func is_valid_ip(ip: String) -> bool:
	var ip_regex = RegEx.new()
	ip_regex.compile(r"^((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$")
	return ip_regex.search(ip) != null or ip == ""

func is_valid_port(port: String) -> bool:
	var port_regex = RegEx.new()
	port_regex.compile(r"^(6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5]?[0-9]{1,4})$")
	return port_regex.search(port) != null
	
