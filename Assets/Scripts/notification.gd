extends Node

var notification_panel = load("res://Scenes/NotificationPanel.tscn")
onready var box = get_node("VBoxContainer")

func show_notification(text, duration, notification_type):
	if box.get_child_count() == 5:
		box.remove_child(box.get_child(0))
	
	var node = notification_panel.instance()
	box.add_child(node, true)
	box.get_child(box.get_child_count()-1).modify_panel(text, duration, notification_type)
	box.get_child(box.get_child_count()-1).start()
