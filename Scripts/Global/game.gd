extends Node2D

@onready var camera = $MultiTargetCamera2D
@onready var target_1 = $Balloon
@onready var target_2 = $Level/Floor

func _ready():
	camera.add_target(target_1)
	camera.add_target(target_2)
