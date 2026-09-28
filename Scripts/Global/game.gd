extends Node2D

@onready var camera = $MultiTargetCamera2D
@onready var target_1 = $Balloon
@onready var target_2 = $Level/Floor
@onready var spawner = $Level/ObjectSpawner

func _ready() -> void:
	spawner.spawn_object()

func _on_open_hand_knockack_area_body_entered(body):
	pass # Replace with function body.
