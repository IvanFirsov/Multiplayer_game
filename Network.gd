extends Node

const DEAFULT_PORT = 28960
const MAX_CLIENTS = 6

var server
var client

var ip_adress = ""

func _ready() -> void:
	if OS.get_name() == "windows":
		ip_adress = IP.get_local_addresses()[3]
	elif OS.get_name() == "android":
		ip_adress = IP.get_local_addresses()[0]

	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_adress = ip

	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func create_server():
	server = NetworkedMultiplayerENet.new()
	server.create_server(DEAFULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(server)

func join_server():
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_adress, DEAFULT_PORT)
	get_tree().set_network_peer(server)

func _connected_to_server():
	print("successfully connected to the server")

func _server_disconnected():
	print("disconnected from the server")
