extends PlayerState

@export var aim_state: PlayerState

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func enter_state() -> void:
	#print("entered cool pose")
	animation_player.play("enter_pose")

func exit_state() -> void:
	animation_player.play("exit_pose")

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		switch_state.emit(aim_state)
