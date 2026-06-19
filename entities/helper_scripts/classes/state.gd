class_name State extends Node

signal switch_state(state: State)

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5

@export_group("Movement")
@export var can_move: bool
@export var move_speed: float = 0.0
@export var acceleration: float = 0.0
@export var rotation_speed: float = 0.0
@export var gravity: float = 0.1

var entity: Entity
var camera: Camera3D

# Play animations and set stats associated with this new_state
func enter_state() -> void:
	pass

# Clean up animations and stats associated with the current state before switching over to a new state
func exit_state() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not can_move:
		entity.velocity = Vector3(0.0, -gravity, 0.0)
		return
	
	var raw_input: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)
	var forward: Vector3 = camera.global_basis.z
	var right: Vector3 = camera.global_basis.x
	
	var move_direction: Vector3 = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	var y_velocity: float = entity.velocity.y
	entity.velocity.y = 0.0
	entity.velocity = entity.velocity.move_toward(move_direction * move_speed, acceleration * delta)
	entity.velocity.y = y_velocity - gravity * delta
	
	
	entity.move_and_slide()
	
	entity.rotate_model(move_direction, rotation_speed, delta)
