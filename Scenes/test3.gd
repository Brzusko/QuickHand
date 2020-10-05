extends Node2D

func _ready():
	HTTP_Request.get_server_list()
	var server_list = yield(HTTP_Request, "function_complete")
	if typeof(server_list) == TYPE_DICTIONARY:
		FileIo.write(server_list, "user://servers.json")
		NotificationNode.show_notification(JSON.print(server_list), 10, 2) 
	else:
		NotificationNode.show_notification(str(server_list)+"\n"+"Function error", 10, 0)
		return
	
