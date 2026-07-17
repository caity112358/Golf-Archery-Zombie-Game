extends PlayerState

@export_group("States")
@export var idle_state: PlayerState
@export var sprint_state: PlayerState
@export var fall_state: PlayerState
@export var jump_state: PlayerState

var counter: int = 0

#func enter_state() -> void:
	#print("entered move")

func update(_delta: float) -> void:
	counter += 1
	if counter >= 40:
		counter = 0
		player.make_sound(Constants.sound_volume.QUIET_SOUND)
	
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
	
	if Input.is_action_pressed("sprint"):
		switch_state.emit(sprint_state)
		return
