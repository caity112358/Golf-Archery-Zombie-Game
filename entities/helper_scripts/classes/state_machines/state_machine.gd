class_name StateMachine extends Node

@export var initial_state: State

var active_state: State

func setup_state_machine() -> void:
	set_active()
	for state: State in get_children():
		setup_states(state)

func set_active() -> void:
	active_state = initial_state
	active_state.enter_state()

func setup_states(state: State) -> void:
	state.switch_state.connect(change_state)

func _process(delta: float) -> void:
	active_state.update(delta)

func _physics_process(delta: float) -> void:
	active_state.physics_update(delta)

func change_state(new_state: State) -> void:
	if new_state == active_state:
		return
	
	active_state.exit_state()
	
	active_state = new_state
	
	active_state.enter_state()
