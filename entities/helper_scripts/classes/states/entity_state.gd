class_name EntityState extends State

@export_group("Movement")
@export var can_move: bool
@export var move_speed: float = 0.0
@export var acceleration: float = 0.0
@export var rotation_speed: float = 0.0
@export var gravity: float = 0.1

var entity: Entity

func physics_update(delta: float) -> void:
	process_movement(delta)

func process_movement(delta: float) -> void:
	if not can_move:
		entity.velocity = entity.velocity.move_toward(Vector3(0.0, -gravity, 0.0), acceleration * delta)
		entity.move_and_slide()
		return
	
	var direction = movement_direction(delta)
	apply_movement(direction, delta)

@warning_ignore("unused_parameter")
func movement_direction(delta: float) -> Vector3:
	return Vector3.ZERO

func apply_movement(direction: Vector3, delta: float) -> void:
	var y_velocity: float = entity.velocity.y
	entity.velocity.y = 0.0
	entity.velocity = entity.velocity.move_toward(direction * move_speed, acceleration * delta)
	entity.velocity.y = y_velocity - gravity * delta
	
	entity.move_and_slide()
	
	entity.rotate_model(direction, rotation_speed, delta)
