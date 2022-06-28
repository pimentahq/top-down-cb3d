extends CharacterBody3D

@export var speed := 5.0
@export var gravity := 9.8
@export var jump_strength := 5.0
@export var number_jumps := 1
@export var rotation_speed := 8.0

@onready var _model_pivot: Node3D = $ModelPivot

const PI_HALF := PI/2

var _current_jump := 0
var _h_rot := 0.0
var _direction := Vector3.ZERO

func _physics_process(delta: float) -> void:
	character_movement(delta)



func character_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Reset the number of jumps on touch the floor
	if is_on_floor():
		_current_jump = 0

	# Handle Jump.		
	if Input.is_action_just_pressed("a_jump") and _current_jump < number_jumps:
		_current_jump += 1
		
		if velocity.y < jump_strength:
			velocity.y = jump_strength
			

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("a_left", "a_right", "a_up", "a_down")
	_h_rot = Vector2(input_dir.x, -input_dir.y).angle()
	
	_direction.x = input_dir.x
	_direction.z = input_dir.y
	
	if _direction:
		velocity.x = _direction.x * speed
		velocity.z = _direction.z * speed
		
		var rot = lerp_angle(_model_pivot.rotation.y, _h_rot + PI_HALF, delta * rotation_speed)
		_model_pivot.rotation.y = rot
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	move_and_slide()
