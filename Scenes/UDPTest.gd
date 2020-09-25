extends Control

onready var udp_service = get_parent().get_node("/root/UDPService");

func _on_Server_pressed():
	udp_service.fire_server();
	pass # Replace with function body.


func _on_Client_pressed():
	udp_service.fire_client();
	pass # Replace with function body.


func _on_Semaphore_pressed():
	udp_service.release_semaphore();
	pass # Replace with function body.
