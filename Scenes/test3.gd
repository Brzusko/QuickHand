extends Node2D

func _ready():
	HTTP_Request.get_server_list()
	var server_list = yield(HTTP_Request, "function_complete")
	if server_list:
		FileIo.write(server_list, "user://servers.json")
	else:
		print("Function error")
		return
