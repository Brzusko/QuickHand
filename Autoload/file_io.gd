extends Node

func write(input, path):
	var file = File.new()
	var regex = RegEx.new()
	regex.compile("(?=\\.).+")
	
	file.open(path, File.WRITE)
	
	match regex.search(path).get_string():
		".json":
			file.store_line(JSON.print(input))
			file.close()
			return 0
		_:
			file.store_line(input)
			file.close()
			return 0

func read(path, if_create):
	var file = File.new()
	var regex = RegEx.new()
	regex.compile("(?=\\.).+")
	
	if not file.file_exists(path):
		if if_create:
			file.open(path, File.WRITE)
			file.close()
			return ""
		print("Error: File does not exist")
		return ""
	
	file.open(path, File.READ)
	
	match regex.search(path).get_string():
		".json":
			var output = JSON.parse(file.get_as_text())
			file.close()
			return output.result
		_:
			var output = file.get_as_text()
			file.close()
			return output
