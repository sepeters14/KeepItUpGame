extends Node

var high_score = 0

#-------------------Save------------------
func save():
	print("HI HI HI SCORE: ", high_score)
	#var save_dict = {
		#"filename" : get_scene_file_path(),
		#"parent" : get_parent().get_path(),
		#"high_score" : high_score
	#} 
	#return save_dict
	SaveManager.save_variable(high_score)

func _ready():
	if SaveManager.is_save_file_present():
		high_score = SaveManager.load_variable(high_score)
