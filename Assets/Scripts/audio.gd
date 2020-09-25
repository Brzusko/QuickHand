extends Node

func _ready():
	var popup = get_node(".")
	SettingsSound._ready()
	get_node("MarginContainer/VSplitContainer2/MarginContainer2/VSplitContainer/VBoxContainer/MusicSlider").value = SettingsSound.mVolume()
	get_node("MarginContainer/VSplitContainer2/MarginContainer2/VSplitContainer/VBoxContainer2/SfxSlider").value = SettingsSound.sfxVolume()

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	SettingsSound.Settings["sound"]["music_volume"] = value
	SettingsSound.save_settings()
	pass # Replace with function body.

func _on_SfxSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	SettingsSound.Settings["sound"]["sfx_volume"] = value
	SettingsSound.save_settings()
	pass # Replace with function body.

func _on_ExitButton_pressed():
	get_node(".").visible = false
	pass # Replace with function body.
