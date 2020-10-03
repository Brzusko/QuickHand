extends Control

enum Enum {ERROR, INFO, SUCCESS}

func _on_Error_pressed():
	NotificationNode.show_notification("lol text", 10, Enum.ERROR)
	pass # Replace with function body.


func _on_Info_pressed():
	NotificationNode.show_notification("lol text", 0, Enum.INFO)
	pass # Replace with function body.


func _on_Success_pressed():
	NotificationNode.show_notification("lol text", 2, Enum.SUCCESS)
	pass # Replace with function body.
