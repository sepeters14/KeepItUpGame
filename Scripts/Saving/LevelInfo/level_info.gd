extends Node

@onready var high_score_label = get_node("HighScoreLabel")

var high_score = 0

#-------------------Save------------------
func save():
	#var save_dict = {
		#"filename" : get_scene_file_path(),
		#"parent" : get_parent().get_path(),
		#"high_score" : high_score
	#} 
	#return save_dict
	
	#SaveManager.save_variable(high_score)
	
	SaveManager.save_data["high_score"] = high_score
	SaveManager.save()

func _ready():
	if SaveManager.is_save_file_present():
		#high_score = SaveManager.load_variable(high_score)
		SaveManager.load()
		high_score = SaveManager.save_data["high_score"]
		
		#labels
		high_score_label.text = str("High-Score: ", high_score) 
