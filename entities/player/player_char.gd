class_name Player extends Entity

@export var aim_state: PlayerState
@export var camera_pivot: Node3D
@export var camera: Camera3D
@export var hurtbox: Area3D

signal sound_made(sound_volume: Constants.sound_volume, location: Vector3)
signal stroke_added(amount_added: int)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	setup_state_machine()
	print(Vector3.FORWARD)
	hurtbox.body_entered.connect(take_damage)

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func setup_state_machine() -> void:
	state_machine.entity = self
	state_machine.camera = camera
	state_machine.camera_pivot = camera_pivot
	state_machine.setup_state_machine()

func pickup_arrow() -> void:
	state_machine.change_state(aim_state)

func take_damage(body: Node3D) -> void:
	if body.has_hit:
		return
	
	add_stroke(body.damage_amount)
	body.set_has_hit(true)

func make_sound(sound_volume: Constants.sound_volume) -> void:
	sound_made.emit(sound_volume, global_position)

func add_stroke(amount_added: int) -> void:
	stroke_added.emit(amount_added)
