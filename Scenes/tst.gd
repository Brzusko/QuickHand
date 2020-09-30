extends Control

enum Enum {NONE, ERROR, INFO, SUCCESS}

var notification_panel = load("res://NotificationPanel.tscn")
onready var box = get_node("VBoxContainer")

func _on_Success_pressed():
	if box.get_child_count()==5:
		box.remove_child(box.get_child(0))
	
	var node = notification_panel.instance()
	box.add_child(node, true)
	box.get_child(box.get_child_count()-1).show_notification("Lol text", 2, Enum.SUCCESS)
	pass # Replace with function body.

func _on_Info_pressed():
	if box.get_child_count()==5:
		box.remove_child(box.get_child(0))
	
	var node = notification_panel.instance()
	box.add_child(node, true)
	node.get_node("VBoxContainer/HBoxContainer/VBoxContainer/Title").text = "Info"
	box.get_child(box.get_child_count()-1).show_notification("Lol text", 0, Enum.INFO)
	pass # Replace with function body.

func _on_Error_pressed():
	if box.get_child_count()==5:
		box.remove_child(box.get_child(0))
	
	var node = notification_panel.instance()
	box.add_child(node, true)
	box.get_child(box.get_child_count()-1).show_notification("Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 10, Enum.ERROR)
	pass # Replace with function body.


func _on_Tree_pressed():
	get_node(".").print_tree_pretty()
	pass # Replace with function body.
