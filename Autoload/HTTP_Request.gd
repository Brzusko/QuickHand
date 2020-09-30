extends Node2D

func make_request():
	$HTTPRequest.request("https://jsonplaceholder.typicode.com/todos/1");
	pass

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if(response_code == 200):
		var Jason = body.get_string_from_utf8();
	pass
