extends Node2D

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
		#print(dict.result);
	pass
