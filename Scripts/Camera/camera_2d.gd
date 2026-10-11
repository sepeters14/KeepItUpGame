extends Camera2D

var shake_intesity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float = 20.0

var noise = FastNoiseLite.new()

func _physics_process(delta: float) -> void:
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intesity,
			noise.get_noise_2d(0, shake_time) * shake_intesity
		)
		shake_intesity = max(shake_intesity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)

func screen_shake(intensity: int, time: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intesity = intensity
	active_shake_time = time
	shake_time = 0.0
