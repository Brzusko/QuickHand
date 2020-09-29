extends Control

enum Enum {NONE, ERROR, INFO, SUCCESS}

var notification_panel = load("res://Notification.tscn")

func _on_Success_pressed():
	var node = notification_panel.instance()
	get_node("VBoxContainer").add_child(node, true)
	get_node("VBoxContainer").get_child(get_node("VBoxContainer").get_child_count()-1).show_notification("Lol text", Enum.SUCCESS)
	pass # Replace with function body.

func _on_Info_pressed():
	var node = notification_panel.instance()
	get_node("VBoxContainer").add_child(node, true)
	get_node("VBoxContainer").get_child(get_node("VBoxContainer").get_child_count()-1).show_notification("Lol text", Enum.INFO)
	pass # Replace with function body.

func _on_Error_pressed():
	var node = notification_panel.instance()
	get_node("VBoxContainer").add_child(node, true)
	get_node("VBoxContainer").get_child(get_node("VBoxContainer").get_child_count()-1).show_notification("Lol text", Enum.ERROR)
	pass # Replace with function body.


func _on_Tree_pressed():
	get_node(".").print_tree_pretty()
	pass # Replace with function body.
