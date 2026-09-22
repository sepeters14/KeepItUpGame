extends Camera2D

@export var balloon: RigidBody2D

#func _physics_process(delta):
	#if balloon.position.y < 18:
		#zoom = lerp(zoom, Vector2(0.5,0.5), 0.08)
	#elif balloon.position.y >= 10:
		#zoom = lerp(zoom, Vector2(1,1), 0.08)


@export var move_speed = 0.5  # camera position lerp speed
@export var zoom_speed = 0.25  # camera zoom lerp speed
@export var min_zoom = 1.5  # camera won't zoom closer than this
@export var max_zoom = 5  # camera won't zoom farther than this
@export var margin = Vector2(400, 200)  # include some buffer area around targets

var targets = []  # Array of targets to be tracked.

var knockback: Vector2 =  Vector2.ZERO
var knockback_timer: float = 0.0

@onready var screen_size = get_viewport_rect().size

func _process(delta):
	if !targets:
		return
	# Keep the camera centered between the targets
	var target_position = Vector2.ZERO
	for target in targets:
		target_position += target.global_position
	target_position /= targets.size()
	global_position = lerp(global_position, target_position, move_speed)
	# Find the zoom that will contain all targets
	var rect = Rect2(global_position, Vector2.ONE)
	for target in targets:
		rect = rect.expand(target.global_position)
	rect = rect.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var d = max(rect.size.x, rect.size.y)
	var zoom_value
	if rect.size.x > rect.size.y * screen_size.aspect():
		zoom_value = clamp(rect.size.x / screen_size.x, min_zoom, max_zoom)
	else:
		zoom_value = clamp(rect.size.y / screen_size.y, min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2.ONE / zoom_value, zoom_speed)

func add_target(target):
	if not target in targets:
		targets.append(target)

func remove_target(target):
	if target in targets:
		targets.erase(target)
