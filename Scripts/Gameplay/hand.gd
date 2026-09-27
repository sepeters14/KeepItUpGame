extends CharacterBody2D

var in_hand
var playing_open_hand_anim = false

@onready var animation_player = $AnimationPlayer

@export var gravity = 20
@export var jump_force = 400
@export var walk_speed = 400

func get_input():
	#var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var input_direction
	if(Input.is_action_pressed("move_left")):
		velocity.x = -walk_speed
	elif(Input.is_action_pressed("move_right")):
		velocity.x = walk_speed
	else:
		velocity.x = 0
	
	if(Input.is_action_just_pressed("jump") and is_on_floor()):
		velocity.y -= jump_force
	if(!is_on_floor() and Input.is_action_just_released("jump")):
		velocity.y = gravity * 2
	if !is_on_floor():
		velocity.y += gravity
	
	if Input.is_action_pressed("action_2"):
		playing_open_hand_anim = false
		animation_player.play("PointHand")
	elif Input.is_action_pressed("action_1"):
		print(playing_open_hand_anim)
		if playing_open_hand_anim == false:
			playing_open_hand_anim = true
			print(playing_open_hand_anim)
			animation_player.play("OpenHandSwing")
	else:
		playing_open_hand_anim = false
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

func _on_open_hand_knockack_area_body_entered(body):
	if body.is_in_group("item"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 800.0, 0.12)

func rotate_hand_right():
	rotation = deg_to_rad(14.0)
func rotate_hand_left():
	rotation = deg_to_rad(-14.0)
