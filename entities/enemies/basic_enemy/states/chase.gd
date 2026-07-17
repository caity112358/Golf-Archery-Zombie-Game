extends EntityState

@export var idle_state: EntityState
@export var fall_state: EntityState
@export var attack_state: EntityState

@onready var sight: Area3D = %Sight

#chase will shamble towards the nearest player
#every few seconds, the zombie might reorient and see if it can find the player
#if the player is close enough, it will attack

func movement_direction(_delta: float) -> Vector3:
	var bodies: Array[Node3D] = sight.get_overlapping_bodies()
	
	if !bodies:
		return Vector3.ZERO
	
	return closest_body(bodies).normalized()

#func closest_body(bodies: Array[Node3D]) -> Vector3:
	#var body_vectors: Array[Node3D] = bodies.map(
		#func(body): 
			#return body.global_position - entity.global_position)
	#var closest_body_vector: Vector3 = body_vectors.reduce(
		#func(minimum, vec): 
			#return vec if is_length_lesser(vec, minimum) else minimum)
	#return closest_body_vector

func closest_body(bodies: Array[Node3D]) -> Vector3:
	return bodies.map(
		func(body: Node3D) -> Vector3: 
			return body.global_position - entity.global_position).reduce(
		func(minimum: Vector3, vector: Vector3) -> Vector3: 
			return vector if is_length_lesser(vector, minimum) else minimum)

func is_length_lesser(vector1: Vector3, vector2: Vector3):
	return vector1.length() < vector2.length()

func update(_delta: float) -> void:
	if not entity.is_on_floor():
		switch_state.emit(fall_state)
		return
	
	if !sight.get_overlapping_bodies():
		switch_state.emit(idle_state)
		return
	
	var closest_enemy_vector = closest_body(sight.get_overlapping_bodies())
	if closest_enemy_vector.length() < 2:
		switch_state.emit(attack_state)
		return
