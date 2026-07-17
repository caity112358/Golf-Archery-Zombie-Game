extends PlayerState

@export var jump_timer: float
@export var jump_force: float

@export var fall_state: PlayerState

func enter_state() -> void:
	#print("entered jump")
	player.velocity.y += jump_force
	player.make_sound(Constants.sound_volume.QUIET_SOUND)
	await get_tree().create_timer(jump_timer).timeout
	gravity = 40

func exit_state() -> void:
	gravity = 0
	if Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	) == Vector2.ZERO:
		player.velocity = Vector3.ZERO

func update(_delta: float) -> void:
	if player.velocity.y <= 0:
		switch_state.emit(fall_state)

func physics_update(delta: float) -> void:
	super.physics_update(delta)
