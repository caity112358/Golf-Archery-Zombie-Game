extends Entity

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5

var camera_input_directon: Vector2 = Vector2.ZERO

@onready var camera_pivot: Node3D = %CameraPivot


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	initialise_state_machine()

func initialise_state_machine() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion: bool = (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		camera_input_directon = event.screen_relative * mouse_sensitivity

func move_camera(delta: float) -> void:
	camera_pivot.rotation.x += camera_input_directon.y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	
	camera_pivot.rotation.y -= camera_input_directon.x * delta
	
	camera_input_directon = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_camera(delta) #check for camera movement in state (aim has diff camera angles)
