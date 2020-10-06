extends Node2D

func _on_Button_pressed():
	HTTP_Request.create_server();
	pass

func _on_Button2_pressed():
	HTTP_Request.create_client();
	pass
