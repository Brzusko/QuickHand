extends Node2D

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
		NotificationNode.show_notification("Something goes wrong with parsing data",10,0);
		return;
	
	#Notification from server
	match dict.result["message"]:
		"ADDED":
			NotificationNode.show_notification("Succesfuly registered server",10,2);
		"FAILED_TO_ADD":
			NotificationNode.show_notification("Failed to register server",10,0);
		"MASTER_SERVER_NOT_FOUND":
			NotificationNode.show_notification("Master server not found",10,0);
	pass




func make_request():
	$HTTPRequest.request("http://52.169.226.95/servers/QuickHand",[],false,HTTPClient.METHOD_GET);
	pass

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if(response_code == 200):
		var dict = {}
		dict = JSON.parse(body.get_string_from_utf8());
		if (dict.error != OK):
			print("Something goes wrong with parsing data");
			return;
		print(dict.result);
	pass




func server_ping(ip,port,players):
	
	#Players dictionary to json
	var query = JSON.print(players);
	
	#Sending request
	$Server_Registration.request("http://52.169.226.95/servers/update_server/QuickHand/"+ip+"/"+port,["Content-Type: application/json"],false,HTTPClient.METHOD_POST,query);
	pass;

func _on_Server_Ping_request_completed(result, response_code, headers, body):
	
	pass
