extends State

@export var jump_timer: float
@export var jump_force: float

@export var fall_state: State


func enter_state() -> void:
	print("entered jump")
	entity.velocity.y += jump_force
	await get_tree().create_timer(jump_timer).timeout
	gravity = 20

func exit_state() -> void:
	gravity = 0

func update(_delta: float) -> void:
	if entity.velocity.y == 0:
		switch_state.emit(fall_state)
