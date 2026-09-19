extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var sprite_animated = $AnimatedSprite2D

func _ready():
	sprite.visible = true
	sprite_animated.visible = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("item"):
		destroy_item()

func destroy_item():
	sprite.visible = false
	sprite_animated.frame = 0
	sprite_animated.visible = true
	sprite_animated.play("pop")
	await sprite_animated.animation_finished
	queue_free()
