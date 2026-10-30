extends Node

const SAVE_PATH = "user://save_data.save"

func save_variable(var_name, var_to_save):
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	print("The var to save is: ",var_to_save)
	save_file.store_var(var_to_save)

func load_variable(var_name):
	if FileAccess.file_exists(SAVE_PATH):
		var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var loaded_data = save_file.get_var()
		print("The var to load is: ",var_name, " it's value is ", loaded_data[var_name])
		return loaded_data[var_name]

func is_save_file_present():
	var truth_flag = false
	if FileAccess.file_exists(SAVE_PATH):
		truth_flag = true
	return truth_flag
