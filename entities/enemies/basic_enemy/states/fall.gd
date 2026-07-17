extends EntityState

@export var idle_state: EntityState

#falls and lands on its arse. might be shocked and will go itno idle state 
#for a bit before looking around and spotting the player again

func movement_direction(_delta: float) -> Vector3:
	return Vector3.FORWARD

func enter_state() -> void:
	entity.queue_free()
