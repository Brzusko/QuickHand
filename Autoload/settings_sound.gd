extends Node

var path = "user://settings.json"

var defaultSettings = {
	"sound" : {
		"music_volume" : 0,
		"sfx_volume" : 0
	}
}

var Settings = { }

func _ready():
	load_settings()
	save_settings()

func load_settings():
	var file = File.new()
	
	if not file.file_exists(path):
		reset_settings()
		return
	
	file.open(path, File.READ)
	
	var text = file.get_as_text()
	
	Settings = parse_json(text)
	
	file.close()

func save_settings():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(Settings))
	
	file.close()

func reset_settings():
	Settings = defaultSettings
	save_settings()

func mVolume():
	return Settings["sound"]["music_volume"]

func sfxVolume():
	return Settings["sound"]["sfx_volume"]
