extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var sprite_animated = $AnimatedSprite2D

var level_killpane : Area2D

var is_being_freed

var knockback: Vector2 =  Vector2.ZERO
var knockback_timer: float = 0.0

func _ready():
	sprite.visible = true
	sprite_animated.visible = false
	is_being_freed = false

func _physics_process(delta):
	if knockback_timer > 0.0:
		knockback_timer -= delta
		#if knockback_timer <= 0.0:
			#knockback = Vector2.ZERO

func destroy_item():
	sprite.visible = false
	sprite_animated.frame = 0
	sprite_animated.visible = true
	sprite_animated.play("pop")
	await sprite_animated.animation_finished
	queue_free()

func apply_knockback(direction: Vector2, force: float, knockback_duration: float) -> void:
	knockback = direction * force
	#apply_central_impulse(knockback) #this makes the balloon not spin
	apply_impulse(knockback, Vector2(-0.1,0)) # this makes the balloon spin while applying the force TODO (make the VECTOR2 a random postion or based on something)
	knockback_timer = knockback_duration


func _on_area_2d_area_entered(area: Area2D) -> void:
	if is_being_freed == false:
		if area.is_in_group("killpane"):
			is_being_freed = true
			destroy_item()
