extends EntityStateMachine

@export var investigate_state: EntityState
#enemy state machine

func investigate_sound(sound_position: Vector3) -> void:
	if active_state.name == "Idle":
		change_state(investigate_state)
		active_state.last_heard_sound = sound_position
