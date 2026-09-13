extends RigidBody2D

var in_hand

func _physics_process(delta):
	position = get_global_mouse_position()
	the_delta = delta

func _input(event):
	if event is InputEventMouseMotion:
		if event.get_relative().x > 0:
			#print("Moving right")
			rotate_hand_right()
			
		if event.get_relative().x < 0:
			#print("Moving left")
			rotate_hand_left()

func _on_area_2d_body_entered(body):
	if body.is_in_group("item"):
		in_hand = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("item"):
		if in_hand == true:
			in_hand = false
			Global.score = Global.score + 1

func rotate_hand_right():
	rotation = deg_to_rad(14.0)
func rotate_hand_left():
	rotation = deg_to_rad(-14.0)
