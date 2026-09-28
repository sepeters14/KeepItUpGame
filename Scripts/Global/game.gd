extends Node2D

@onready var camera = $MultiTargetCamera2D
@onready var spawner = $Level/ObjectSpawner

func _ready() -> void:
	spawner.spawn_object()
