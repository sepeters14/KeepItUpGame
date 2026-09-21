extends CharacterBody2D

var in_hand

@onready var animation_player = $AnimationPlayer

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	if Input.is_action_pressed("action_2"):
		animation_player.play("PointHand")
	elif Input.is_action_pressed("action_1"):
		animation_player.play("OpenHandSwing")
	else:
		animation_player.play("ClosedHand")
func _physics_process(delta):
	get_input()
	move_and_slide()

#func _input(event):
	#if event.get_relative().x > 0:
		##print("Moving right")
		#rotate_hand_right()
		#
	#if event.get_relative().x < 0:
		##print("Moving left")
		#rotate_hand_left()

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
