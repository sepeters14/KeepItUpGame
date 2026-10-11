extends Node2D

@onready var camera = $Camera
@onready var spawner = $Level/ObjectSpawner

func _ready() -> void:
	spawner.spawn_object()

func screen_shake(intensity: int, time: float):
	camera.screen_shake(intensity, time)
