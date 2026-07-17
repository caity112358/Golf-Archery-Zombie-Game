extends PlayerState

@export var idle_state: PlayerState
@export var move_state: PlayerState
@export var fall_state: PlayerState
@export var jump_state: PlayerState

var counter: int = 0

#func enter_state() -> void:
	#print("entered sprint")

func update(_delta: float) -> void:
	counter += 1
	if counter >= 20:
		counter = 0
		player.make_sound(Constants.sound_volume.LOUD_SOUND)
	
	if !player.is_on_floor():
		switch_state.emit(fall_state)
		return
	
	if Input.is_action_just_pressed("jump"):
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
	
	if !Input.is_action_pressed("sprint"):
		switch_state.emit(move_state)
		return
