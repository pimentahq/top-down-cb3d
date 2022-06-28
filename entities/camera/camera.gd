extends Position3D

@export var camera_interpolation := true
@export var smothiness := 0.1

@onready var _player: CharacterBody3D = %Player

func _process(delta: float) -> void:
	move_camera()
	

func move_camera() -> void:
	if camera_interpolation:
		if position.distance_to(_player.position) > 0.1:
			position = position.lerp(_player.position, smothiness)
	else:
		position = _player.position
