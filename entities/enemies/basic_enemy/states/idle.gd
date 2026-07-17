extends EntityState

@export var chase_state: EntityState
@export var fall_state: EntityState

@onready var sight: Area3D = %Sight

#Looks around for a player, then transitions into a fall state
#can mayve shamble around and fall if it goes off an edge

func update(_delta: float) -> void:
	if not entity.is_on_floor():
		switch_state.emit(fall_state)
		return
	
	var bodies: Array[Node3D] = sight.get_overlapping_bodies()
	
	if bodies:
		switch_state.emit(chase_state)
		return
