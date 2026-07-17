extends PlayerState

@export var move_state: PlayerState
@export var fall_state: PlayerState
@export var jump_state: PlayerState
@export var aim_state: PlayerState

#func enter_state() -> void:
	#print("entered idle")

func update(_delta: float) -> void:
	if not player.is_on_floor():
		switch_state.emit(fall_state)
		return
	
	if Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	) != Vector2.ZERO:
		switch_state.emit(move_state)
		return
	
	if Input.is_action_just_pressed("jump"):
		switch_state.emit(jump_state)
		return
