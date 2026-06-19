class_name StateMachine extends Node

@export var entity: Entity
@export var initial_state: State
@export var camera: Camera3D

var active_state: State

func _ready() -> void:
	active_state = initial_state
	for state: State in get_children():
		state.entity = entity
		state.camera = camera
		state.switch_state.connect(change_state)

func _process(delta: float) -> void:
	if active_state:
		active_state.update(delta)

func _physics_process(delta: float) -> void:
	if active_state:
		active_state.physics_update(delta)

func change_state(new_state: State) -> void:
	if new_state == active_state:
		return
	
	if active_state:
		active_state.exit_state()
	
	active_state = new_state
	
	if active_state:
		active_state.enter_state()
