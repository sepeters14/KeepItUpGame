extends Node

const SAVE_PATH = "user://save_data.json"

var save_data := {
	"high_score" : 0,
}

func _ready():
	load_game()

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("failed to create save file: ", FileAccess.get_open_error())
		return
	# TODO (WHAT I SHOULD DO) will go through and check for nodes in a saving group and 
	# then update the values in save function on those nodes https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
	var save_data := {
		"high_score" : Global.high_score,
	}
	var json_string := JSON.stringify(save_data, "\t")
	print("HI SCO", save_data["high_score"])
	file.store_string(json_string)
	file.close()
	print("Game saved successfully")

func load_game():
	if !FileAccess.file_exists(SAVE_PATH):
		print("No save file found")
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("failed to open saved file", FileAccess.get_open_error())
		return
	
	var json_string := file.get_as_text()
	file.close()
	
	var json := JSON.new()
	var parse_result = json.parse(json_string)
	
	if parse_result == OK:
		var loaded_data = json.data
		if typeof(loaded_data) == TYPE_DICTIONARY:
			for key in loaded_data:
				save_data[key] = loaded_data[key]
				print("Game Load Succesful")
		else:
			push_error("Save file format invalid")
	else:
		push_error("JSON parse error: ", json.get_error_message(), " at line ", json.get_error_line())
