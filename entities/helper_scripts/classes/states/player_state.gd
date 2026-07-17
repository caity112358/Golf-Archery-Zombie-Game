class_name PlayerState extends EntityState

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5
@export_range(-PI / 2, PI / 2) var top_camera_bound: float = PI / 3.0
@export_range(-PI / 2, PI / 2) var bottom_camera_bound: float = -PI / 6.0

var camera: Camera3D
var camera_pivot: Node3D
var camera_input_direction: Vector2 = Vector2.ZERO
var player: Player:
	get(): return entity as Player

@warning_ignore("unused_parameter")
func movement_direction(delta: float) -> Vector3:
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
	return move_direction.normalized()

func process_camera(delta) -> void: 
	if camera_input_direction == Vector2.ZERO:
		return
	
	move_camera(delta)

func move_camera(delta: float) -> void:
	camera_input_direction *= mouse_sensitivity
	
	camera_pivot.rotation.x += camera_input_direction.y * delta
	camera_pivot.rotation.x = clamp(
		camera_pivot.rotation.x, 
		bottom_camera_bound, 
		top_camera_bound
		)
	
	camera_pivot.rotation.y -= camera_input_direction.x * delta
	
	camera_input_direction = Vector2.ZERO

func physics_update(delta: float) -> void:
	process_camera(delta)
	process_movement(delta)
