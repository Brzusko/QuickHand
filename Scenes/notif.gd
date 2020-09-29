extends MarginContainer

enum Enum {NONE, ERROR, INFO, SUCCESS}

func start():
	var timer = get_node("Timer")
	var tween = get_node("Tween")
	
	tween.interpolate_property(get_node("."), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1), 0.5)
	tween.start()
	
	timer.start()
	while(!timer.is_stopped()):
		yield(get_tree().create_timer(0.01),"timeout")
		get_node("VBoxContainer/ProgressBar").value = timer.time_left/5
		
	tween.interpolate_property(get_node("."), "modulate", Color(1, 1, 1), Color(1, 1, 1, 0), 0.5)
	tween.start()
	
	yield(get_tree().create_timer(0.5),"timeout")
	get_parent().remove_child(self)

func show_notification(gText, type):
	get_node("VBoxContainer/HBoxContainer/VBoxContainer/Text").text = gText
	get_node(".").visible = true
	var background_color = StyleBoxFlat.new()
	match type:
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
	start()
