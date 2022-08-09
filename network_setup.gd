extends Control

onready var multiplayer_config_UI = $multiplayer_configure
onready var server_IP_adress = $multiplayer_configure/server_ip_adress

onready var device_IP_adress = $CanvasLayer/device_ip_adress

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "player_connected")
	get_tree().connect("network_peer_disconnected", self, "player_disconnected")
	get_tree().connect("connect_to_server", self, "_connect_to_server")

	device_IP_adress.text = Network.ip_adress

func player_connected(id):
	print("Player " + str(id) + " has connected")

func player_disconnected(id):
	print("Player " + str(id) + " has disconnected")

func _on_create_server_pressed() -> void:
	multiplayer_config_UI.hide()
	Network.create_server()

func _on_join_server_pressed() -> void:
	if server_IP_adress.text != "":
		multiplayer_config_UI.hide()
		Network.ip_adress = server_IP_adress.text
		Network.join_server()
