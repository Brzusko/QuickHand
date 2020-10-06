extends Node


func _on_Play_pressed():
	var test = load("res://Scenes/test3.tscn").instance()
	get_node(".").add_child_below_node(get_node("PopupPanel"), test, true)
	pass


func _on_Settings_pressed():
	$PopupPanel.show();
	pass


func _on_Exit_pressed():
	get_tree().quit();
	pass 


func _on_Server_test_pressed():
	HTTP_Request.create_server();
	pass


func _on_Client_Test_pressed():
	HTTP_Request.create_client();
	pass
