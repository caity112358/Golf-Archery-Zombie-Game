extends PlayerState

@export_group("States")
@export var idle_state: PlayerState
@export var move_state: PlayerState
@export var sprint_state: PlayerState
@export var jump_state: PlayerState

var coyote_mode: bool = true
var coyote_time: float = 0.25

func enter_state() -> void:
	#print("entered fall")
	await get_tree().create_timer(coyote_time).timeout
	coyote_mode = false

func exit_state() -> void:
	player.make_sound(Constants.sound_volume.LOUD_SOUND)
	coyote_mode = true

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and coyote_mode:
		switch_state.emit(jump_state)
	
	if not player.is_on_floor():
		return
	
	if Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	) == Vector2.ZERO:
		switch_state.emit(idle_state)
		return
	
	if not Input.is_action_pressed("sprint"):
		switch_state.emit(move_state)
		return
	
	switch_state.emit(sprint_state)
