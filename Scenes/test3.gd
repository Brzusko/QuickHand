extends Node2D

func _ready():
	HTTP_Request.get_server_list()
	var server_list = yield(HTTP_Request, "function_complete")
	FileIo.write(server_list, "user://servers.json")
