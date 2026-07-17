extends EntityState

@export var idle_state: EntityState
@export var chase_state: EntityState

@onready var sight: Area3D = %Sight

var last_heard_sound: Vector3
var at_sound: bool = false

func movement_direction(_delta: float) -> Vector3:
	var sound_distance = last_heard_sound - entity.global_position
	return sound_distance.normalized() if sound_distance.length() > 1 else Vector3.ZERO

func enter_state() -> void:
	at_sound = false

func exit_state() -> void:
	at_sound = false

func update(_delta: float) -> void:
	var bodies: Array[Node3D] = sight.get_overlapping_bodies()
	
	if bodies:
		switch_state.emit(chase_state)
		return
	
	if at_sound:
		return
	
	if (last_heard_sound - entity.global_position).length() < 1:
		at_sound = true
		await get_tree().create_timer(5).timeout
		
		if not at_sound:
			return
		
		switch_state.emit(idle_state)
		return
