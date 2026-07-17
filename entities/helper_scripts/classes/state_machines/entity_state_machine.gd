class_name EntityStateMachine extends StateMachine

var entity: Entity

func setup_state_machine() -> void:
	set_active()
	for state: EntityState in get_children():
		setup_entity_states(state)

func setup_entity_states(state: EntityState) -> void:
	state.entity = entity
	setup_states(state)
