extends Node

var player
var popup
var Settings_Sound = load("res://Assets/Scripts/Settings_Sound.gd").new()

func _ready():
	popup = get_node(".")
	Settings_Sound._ready()
	get_node("MarginContainer/VSplitContainer2/VSplitContainer/VBoxContainer/Music_slider").value = Settings_Sound.mVolume()
	get_node("MarginContainer/VSplitContainer2/VSplitContainer/VBoxContainer2/Sfx_slider").value = Settings_Sound.sfxVolume()

func _on_Music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	Settings_Sound.Settings["sound"]["music_volume"] = value
	Settings_Sound.save_settings()
	pass # Replace with function body.


func _on_Sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	Settings_Sound.Settings["sound"]["sfx_volume"] = value
	Settings_Sound.save_settings()
	pass # Replace with function body.


func _on_Button_pressed():
	popup.visible = false
	pass # Replace with function body.
