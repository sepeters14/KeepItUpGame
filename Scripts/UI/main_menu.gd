extends Control

@onready var start_button = $VBoxContainer/Start
@onready var stats_button = $VBoxContainer/Stats
@onready var quit_button = $VBoxContainer/Quit




func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_stats_pressed() -> void:
	print("need new ui scene here")
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
