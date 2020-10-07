extends Node

var notification_panel = load("res://Scenes/NotificationPanel.tscn")
onready var box = get_node("CanvasLayer/VBoxContainer")

func show_notification(text, duration, notification_type):
	var node = notification_panel.instance()
	box.add_child(node, true)
	box.get_child(box.get_child_count()-1).modify_panel(text, duration, notification_type)
	yield(VisualServer, "frame_post_draw")
	var panel_size_sum = 0
	
	for i in range(box.get_child_count()):
		panel_size_sum += box.get_child(i).get_node(".").rect_size.y

	if box.get_child_count() == 1 and panel_size_sum >= box.rect_size.y:
		var log_text = FileIo.read("user://log.txt", true)+text+"\n\n"
		FileIo.write(log_text, "user://log.txt")

	while panel_size_sum >= box.rect_min_size.y*box.rect_scale.y:
		panel_size_sum -= box.get_child(0).get_node(".").rect_size.y
		box.remove_child(box.get_child(0))
	
	if not box.rect_size.y ==  box.rect_min_size.y*box.rect_scale.y:
		box.rect_size.y = box.rect_min_size.y*box.rect_scale.y
		
	box.get_child(box.get_child_count()-1).start()
