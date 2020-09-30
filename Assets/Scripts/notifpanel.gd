extends MarginContainer

enum Enum {ERROR, INFO, SUCCESS}
var time = 5

func start():
	var notification_duration = get_node("NotificationDuration")
	notification_duration.wait_time = time
	get_node("VBoxContainer/ProgressBar").max_value = time
	var tween = get_node("Tween")
	
	tween.interpolate_property(get_node("."), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1), 0.5)
	tween.start()
	
	notification_duration.start()
	while(!notification_duration.is_stopped()):
		if get_parent():
			yield(get_tree().create_timer(0.001), "timeout")
		else: return
		get_node("VBoxContainer/ProgressBar").value = notification_duration.time_left
		
	tween.interpolate_property(get_node("."), "modulate", Color(1, 1, 1), Color(1, 1, 1, 0), 0.5)
	tween.start()
	
	if get_parent():
		yield(get_tree().create_timer(0.5),"timeout")
	else: return
	if get_parent():
		get_parent().remove_child(self)
	else: return

func modify_panel(gText, duration, notification_type):
	get_node("VBoxContainer/HBoxContainer/VBoxContainer/Text").text = gText
	if duration > 0:
		time = duration
	var background_color = StyleBoxFlat.new()
	match notification_type:
		Enum.ERROR:
			background_color.set_bg_color(Color(0.717647, 0.184314, 0.184314))
			get_node("Panel").set("custom_styles/panel", background_color)
			get_node("VBoxContainer/HBoxContainer/CenterContainer/TextureRect").texture = load("res://Assets/Textures/warning.png")
			get_node("VBoxContainer/HBoxContainer/VBoxContainer/Title").text = "Error"
		Enum.INFO:
			background_color.set_bg_color(Color(0.184314, 0.517647, 0.717647))
			get_node("Panel").set("custom_styles/panel", background_color)
			get_node("VBoxContainer/HBoxContainer/CenterContainer/TextureRect").texture = load("res://Assets/Textures/info.png")
			get_node("VBoxContainer/HBoxContainer/VBoxContainer/Title").text = "Info"
		Enum.SUCCESS:
			background_color.set_bg_color(Color(0.156863, 0.623529, 0.329412))
			get_node("Panel").set("custom_styles/panel", background_color)
			get_node("VBoxContainer/HBoxContainer/CenterContainer/TextureRect").texture = load("res://Assets/Textures/succ.png")
			get_node("VBoxContainer/HBoxContainer/VBoxContainer/Title").text = "Success"
