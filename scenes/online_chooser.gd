extends Control

func _on_backtomain_pressed():
	Transitioner.fadeTransition(load("res://scenes/mainmenu.tscn"))


func _ready():
	refreshServers()

func _on_add_pressed():
	$AnimationPlayer.play("slide")


func _on_backtobasic_pressed():
	$AnimationPlayer.play_backwards("slide")

func refreshServers():
	var config = ConfigFile.new()
	var err = config.load("user://server_config.ini")
	var serverCard = load("res://scenes/server_card.tscn")
	if err != OK:
		return
	for server in config.get_sections():
		var newServerCard = serverCard.instantiate()
		var text = ""
		for key in config.get_section_keys(server):
			if key.is_valid_int():
				pass
			else:
				if text != "":
					text = text + str(config.get_value(server,key)) + ":"
				else:
					text = text + str(config.get_value(server,key)) + ":"
		newServerCard.text = text
		$Basic/MarginContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer.add_child(newServerCard)
		


func _on_add_to_list_pressed():
	var ip = $AddServer/MarginContainer/VBoxContainer/HBoxContainer/IP.text
	var port = $AddServer/MarginContainer/VBoxContainer/HBoxContainer/PORT.text
	addServer(port,ip)
	
func addServer(port,ip):
	var config = ConfigFile.new()
	var err = config.load("user://server_config.ini")
	var serverCard = load("res://scenes/server_card.tscn")
	var servercount = config.get_value("basic","servercount",0)
	config.set_value("server"+str(servercount+1),"ip",ip)
	config.set_value("server"+str(servercount+1),"port",port)
	config.set_value("server"+str(servercount+1),"number",servercount+1)
	config.set_value("basic","servercount",servercount+1)
	print("ADDED SERVER"+str(servercount)+" with "+str(ip,port))
	config.save("user://server_config.ini")
	refreshServers()
	$AnimationPlayer.play_backwards("slide")
	
