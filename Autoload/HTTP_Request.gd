extends Node2D

var dict = {}
signal request_complete
signal function_complete(outputs)

#Server registration
func register_server():
	var data = {
		"address": "127.0.0.1",
		"port": 7171,
		"server_name": "Maro testing",
		"max_players": 2,
		"max_count": 3,
	}
	
	var query = JSON.print(data);
	$Server_Registration.request("http://52.169.226.95/servers/register/QuickHand",["Content-Type: application/json"],false,HTTPClient.METHOD_POST,query);
	pass

func _on_Server_Registration_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8());
	pass

func get_server_list():
	$HTTPRequest.request("http://52.169.226.95/servers/QuickHand",[],false,HTTPClient.METHOD_GET);
	yield(self, "request_complete")
	emit_signal("function_complete", dict.result)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if(response_code == 200): 
		dict = JSON.parse(body.get_string_from_utf8());
		if (dict.error != OK):
			print("Something goes wrong with parsing data");
			return;
		#print("Write ",dict.result);
		emit_signal("request_complete")
	pass

