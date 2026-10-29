extends Node2D

@onready var camera = $Camera
@onready var object_spawner = $Level/ObjectSpawner
@onready var item_spawner = $Level/ItemSpawner

func _ready() -> void:
	object_spawner.spawn_object()
	item_spawner.spawn_object()

func screen_shake(intensity: int, time: float):
	camera.screen_shake(intensity, time)
