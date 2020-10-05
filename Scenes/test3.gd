extends Node2D

func _ready():
	HTTP_Request.get_server_list()
	var server_list = yield(HTTP_Request, "function_complete")
	if server_list:
		FileIo.write(server_list, "user://servers.json")
		get_node("Label").text = server_list
	else:
		get_node("Label").text = "Function error"
		return
