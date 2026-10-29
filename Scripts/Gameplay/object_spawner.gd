extends Node2D

@export var object_to_spawn: PackedScene

@onready var spawn_points = $SpawnPoints.get_children()
@onready var killpane_for_object = $Area2DForKillingObjects

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("DEBUG_respawn_enemy"):
		spawn_object()

func spawn_object():
	var object_instance = object_to_spawn.instantiate()
	object_instance.global_position = get_spawn_position()
	get_tree().current_scene.add_child(object_instance)
	
func get_spawn_position():
	var spawn_pos = spawn_points.pick_random()
	return spawn_pos.global_position
	
	
