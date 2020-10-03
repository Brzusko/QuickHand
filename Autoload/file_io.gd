extends Node

func write(dictionary, path):
	var file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(JSON.print(dictionary))
	
	file.close()

func read(path):
	var file = File.new()
	
	if not file.file_exists(path):
		print("Error: File does not exist")
		return 0
	
	file.open(path, File.READ)
	
	var output = JSON.parse(file.get_as_text())

	file.close()
	
	return output.result
