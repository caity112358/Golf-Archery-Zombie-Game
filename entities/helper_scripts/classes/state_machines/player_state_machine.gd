class_name PlayerStateMachine extends EntityStateMachine

var camera: Camera3D
var camera_pivot: Node3D

func setup_player_states(state: PlayerState) -> void:
	state.camera_pivot = camera_pivot
	state.camera = camera
	setup_entity_states(state)

func setup_state_machine() -> void:
	set_active()
	for state: PlayerState in get_children():
		setup_player_states(state)

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
		active_state.camera_input_direction = event.screen_relative

func _physics_process(delta: float) -> void:
	active_state.physics_update(delta)
