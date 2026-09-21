extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var sprite_animated = $AnimatedSprite2D

var is_being_freed

func _ready():
	sprite.visible = true
	sprite_animated.visible = false
	is_being_freed = false

func _on_area_2d_body_entered(body):
	if is_being_freed == false:
		if body.is_in_group("item"):
			is_being_freed = true
			destroy_item()

func destroy_item():
	sprite.visible = false
	sprite_animated.frame = 0
	sprite_animated.visible = true
	sprite_animated.play("pop")
	await sprite_animated.animation_finished
	queue_free()
