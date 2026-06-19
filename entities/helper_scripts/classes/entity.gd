class_name Entity extends CharacterBody3D

var last_movement_direction: Vector3 = Vector3.BACK
@onready var model: Node3D = %Model

func rotate_model(move_direction: Vector3, rotation_speed: float, delta: float) -> void:
	if move_direction.length() > 0.2:
		last_movement_direction = move_direction
	var target_angle: float = Vector3.BACK.signed_angle_to(
		last_movement_direction, 
		Vector3.UP
	)
	
	model.global_rotation.y = lerp_angle(
		model.global_rotation.y, 
		target_angle, 
		rotation_speed * delta
	)
