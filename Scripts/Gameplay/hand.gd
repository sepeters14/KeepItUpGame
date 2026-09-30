extends CharacterBody2D

var in_hand
var playing_open_hand_anim = false
var item_in_area_2d = null

@onready var animation_player = $AnimationPlayer

@onready var point_sprite = $HandPoint
@onready var point_area_image = $HandPointArea2D/PointArea
@onready var point_area_2d = $HandPointArea2D

@export var gravity = 20
@export var jump_force = 400
@export var walk_speed = 400

@export var knockback_force_swing: float = 800.0
@export var knockback_force_pointer: float = 1100.0
@export var knockback_duration: float  = 0.12

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
		point_sprite.position = Vector2(-1.005,-10.005)
		point_area_image.visible = true
	elif Input.is_action_pressed("action_1"):
		if playing_open_hand_anim == false:
			playing_open_hand_anim = true
			animation_player.play("OpenHandSwing")
	else:
		playing_open_hand_anim = false
		animation_player.play("ClosedHand")
	
	if Input.is_action_just_released("action_2"):
		if item_in_area_2d != null:
			print("REALEASED the item is: ",item_in_area_2d)
			point_area_image.visible = false
			#point_area_2d.monitoring = true
			item_in_area_2d.apply_knockback(Vector2.UP, knockback_force_pointer, knockback_duration)
			point_sprite.global_position = item_in_area_2d.global_position
			#await get_tree().create_timer(2).timeout
			#point_area_2d.monitoring = false
			#point_sprite.position = Vector2(-1.005,-10.005)
		

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
		body.apply_knockback(knockback_direction, knockback_force_swing, knockback_duration)

func _on_hand_point_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		print("is in pointer area")
		item_in_area_2d = body
		print("the 2d_item_in_area: ",item_in_area_2d)

func _on_hand_point_area_2d_body_exited(body):
	item_in_area_2d = null
	print("item left the area")
	print("the 2d_item_in_area: ",item_in_area_2d)

func rotate_hand_right():
	rotation = deg_to_rad(14.0)
func rotate_hand_left():
	rotation = deg_to_rad(-14.0)
