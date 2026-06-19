extends State

@export var idle_state: State
@export var sprint_state: State
@export var fall_state: State
@export var jump_state: State

func enter_state() -> void:
	print("entered move")

func update(_delta: float) -> void:
	if !entity.is_on_floor():
		switch_state.emit(fall_state)
		return
	
	if Input.is_action_pressed("jump"):
		switch_state.emit(jump_state)
	
	
	var raw_input: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)
	if raw_input == Vector2.ZERO:
		switch_state.emit(idle_state)
		return
	
	if Input.is_action_pressed("sprint"):
		switch_state.emit(sprint_state)
		return
