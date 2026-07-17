class_name State extends Node

@warning_ignore("unused_signal")
signal switch_state(state: State)

# Play animations and set stats associated with this new_state
func enter_state() -> void:
	pass

# Clean up animations and stats associated with the current state before switching over to a new state
func exit_state() -> void:
	pass

@warning_ignore("unused_parameter")
func update(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	pass
