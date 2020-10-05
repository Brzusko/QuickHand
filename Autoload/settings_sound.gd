extends Node

var path = "user://settings.json"

var defaultSettings = {
	"sound" : {
		"music_volume" : 0,
		"sfx_volume" : 0
	}
}

var settings = { }

func _ready():
	load_settings()
	save_settings()

func load_settings():
	var temp = FileIo.read(path)
	
	if not temp:
		reset_settings()
	else: settings = temp

func save_settings():
	FileIo.write(settings, path)

func reset_settings():
	settings = defaultSettings
	save_settings()

func get_music_volume():
	return settings["sound"]["music_volume"]

func get_sfx_volume():
	return settings["sound"]["sfx_volume"]
