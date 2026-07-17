extends PlayerState

var sharp_aim: bool = false
var can_shoot: bool = true

@export_group("States")
@export var idle_state: State

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var arrow: PackedScene = load(Constants.SCENE_PATHS.arrow)

func enter_state() -> void:
	#print("entered aim")
	sharp_aim = false
	can_shoot = true
	animation_player.play("enter_aim")

func exit_state() -> void:
	animation_player.play("exit_aim")

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("right_click"):
		sharp_aim = true
	
	if sharp_aim and can_shoot and not Input.is_action_pressed("right_click"):
		#spawn arrow and let it fly
		sharp_aim = false
		can_shoot = false
		spawn_arrow()
		switch_state.emit(idle_state)

func physics_update(delta: float) -> void:
	aim_model(delta)
	super.physics_update(delta)

func spawn_arrow() -> void:
	var new_arrow = arrow.instantiate()
	
	#print(camera.global_basis.z)
	
	player.add_sibling(new_arrow)
	new_arrow.global_position = player.global_position + Vector3(0, 1, 0)
	new_arrow.rotation.y = camera.global_rotation.y
	new_arrow.set_speed(-camera.global_basis.z)
	player.add_stroke(1)
	
	#print("shot arrow")


func aim_model(delta: float) -> void:
	var camera_aim: Vector3 = Vector3(
		sin(camera_pivot.rotation.y), 
		0.0, 
		cos(camera_pivot.rotation.y)
		)
	player.rotate_model(camera_aim, 5, delta)
