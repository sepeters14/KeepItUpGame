extends Node2D

@export var object_to_spawn: PackedScene

@onready var spawn_points = self.get_children()

func spawn_object():
	var object_instance = object_to_spawn.instantiate()
	object_instance.global_position = get_spawn_position()
	get_tree().current_scene.add_child(object_instance)
	
func get_spawn_position():
	var spawn_pos = spawn_points.pick_random()
	return spawn_pos.global_position
	
	
