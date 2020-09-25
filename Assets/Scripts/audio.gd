extends Node

func _ready():
	get_node("MarginContainer/VSplitContainer2/MarginContainer2/VSplitContainer/VBoxContainer/MusicSlider").value = SettingsSound.get_music_volume()
	get_node("MarginContainer/VSplitContainer2/MarginContainer2/VSplitContainer/VBoxContainer2/SfxSlider").value = SettingsSound.get_sfx_volume()

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	SettingsSound.settings["sound"]["music_volume"] = value
	SettingsSound.save_settings()
	pass # Replace with function body.

func _on_SfxSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	SettingsSound.settings["sound"]["sfx_volume"] = value
	SettingsSound.save_settings()
	pass # Replace with function body.

func _on_ExitButton_pressed():
	get_node(".").visible = false
	pass # Replace with function body.
