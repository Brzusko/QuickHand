extends Node2D

var dict = {}
signal request_complete(is_failed)
signal function_complete(outputs)

#Server creation
func create_server():
	var server_port = 7171;
	var max_slots = 2;
	
	var peer = NetworkedMultiplayerENet.new();
	peer.create_server(server_port, max_slots);
	get_tree().network_peer = peer
	
	register_server("127.0.0.1",server_port,"Testing",max_slots,3);
	
	pass

#Client creation
func create_client():
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1", 7171)
	get_tree().network_peer = peer
	
	pass

#Server registration
func register_server(address,port,s_name,players,count):
	
	#Data to dictionary
	var data = {
		"address": address,
		"port": port,
		"server_name": s_name,
		"max_players": players,
		"max_count": count,
	}
	
	#Dictionary to json
	var query = JSON.print(data);
	
	#Sending request
	$Server_Registration.request("http://52.169.226.95/servers/register/QuickHand",["Content-Type: application/json"],false,HTTPClient.METHOD_POST,query);
	pass

func _on_Server_Registration_request_completed(result, response_code, headers, body):
	
	#Json to dictionary
	var dict = {}
	dict = JSON.parse(body.get_string_from_utf8());
	
	#Json error test
	if (dict.error != OK):
		print(dict);
		NotificationNode.show_notification("Something goes wrong with parsing data on registration",10,0);
		return;
	
	#Notification from server
	match dict.result["message"]:
		"ADDED":
			NotificationNode.show_notification("Succesfuly registered server",10,2);
			server_ping("127.0.0.1",7171);
			$Ping.start();
		"FAILED_TO_ADD":
			NotificationNode.show_notification("Failed to register server",10,0);
		"MASTER_SERVER_NOT_FOUND":
			NotificationNode.show_notification("Master server not found",10,0);
	pass

func get_server_list():
	$HTTPRequest.request("http://52.169.226.95/servers/QuickHand",[],false,HTTPClient.METHOD_GET);
	if not yield(self, "request_complete"):
		emit_signal("function_complete", dict.result)
	else:
		emit_signal("function_complete")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200: 
		dict = JSON.parse(body.get_string_from_utf8());
		if (dict.error != OK):
			print("Something goes wrong with parsing data");
			emit_signal("request_complete", true)
			return;
		#print("Write ",dict.result);
		emit_signal("request_complete", false)
	else:
		print("Connection error: ",response_code)
		emit_signal("request_complete", true)

func server_ping(ip,port):
	
	var data = {
		"players": [
			{"player_name": "Test 1", "id": 1231},
			{"player_name": "Test 2", "id": 12331}
	]
	};
	
	#print(data.players);
	
	#Players dictionary to json
	var query = JSON.print(data);
	
	#Sending request
	$Server_Ping.request("http://52.169.226.95/servers/update_server/QuickHand/"+str(ip)+"/"+str(port),["Content-Type: application/json"],false,HTTPClient.METHOD_POST,query);
	pass;

func _on_Server_Ping_request_completed(result, response_code, headers, body):
	
	#Json to dictionary
	var dict = {}
	dict = JSON.parse(body.get_string_from_utf8());
	print(dict.result);
	
	#Json error test
	if (dict.error != OK):
		NotificationNode.show_notification("Something goes wrong with parsing data on update",10,0);
		return;
	
	#Notification from server
	match dict.result["message"]:
		"SERVER_UPDATED":
			NotificationNode.show_notification("Server updated",10,2);
		"SERVER_NOT_FOUND":
			NotificationNode.show_notification("Server not found",10,0);
		"MASTER_SERVER_NOT_FOUND":
			NotificationNode.show_notification("Master server not found",10,0);
		"MISSING_DATA_IN_DICTIONARY":
			NotificationNode.show_notification("Missing data in dictionary",10,0);
	pass

func _on_Ping_timeout():
	server_ping("127.0.0.1",7171);
	pass