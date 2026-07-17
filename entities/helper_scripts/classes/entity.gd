class_name Entity extends CharacterBody3D

@export var model: Node3D
@export var state_machine: EntityStateMachine

var last_movement_direction: Vector3 = Vector3.ZERO

func rotate_model(move_direction: Vector3, rotation_speed: float, delta: float) -> void:
	if move_direction.length() > 0.2:
		last_movement_direction = move_direction
	
	var target_angle: float = Vector3.FORWARD.signed_angle_to(
		last_movement_direction, 
		Vector3.UP
	)
	
	model.global_rotation.y = lerp_angle(
		model.global_rotation.y, 
		target_angle, 
		rotation_speed * delta
	)

func _ready() -> void:
	setup_state_machine()

func setup_state_machine() -> void:
	state_machine.entity = self
	state_machine.setup_state_machine()
