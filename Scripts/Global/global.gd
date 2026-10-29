extends Node

var score = 0
var high_score = 0

#-------------------Player Upgradeable------------------
var max_jumps = 1 # This number plus one is the max amount of walljumps 
var normal_jump_force = 400
var wall_jump_jump_force = 450
var move_speed = 400

#-------------------Save------------------
func save():
	print("HI HI HI SCORE: ", high_score)
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"high_score" : high_score
	}
	return save_dict

func _ready():
	print("Your high score is: ", high_score, "!")
