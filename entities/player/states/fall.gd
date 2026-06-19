extends State

@export_group("States")
@export var idle_state: State

func enter_state() -> void:
	print("entered fall")

func update(_delta: float) -> void:
	if entity.is_on_floor():
		switch_state.emit(idle_state)
