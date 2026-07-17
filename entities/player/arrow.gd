class_name Arrow extends CharacterBody3D

#sparkles and shine to keep the players eye on it
	#one area3d checks for walls
	#one area3d checks for floors
#when it lands, it should output a beam of light
@export_range(0, 100) var arrow_speed: int = 80
@onready var area_3d: Area3D = $Area3D

func set_speed(move_direction: Vector3) -> void:
	velocity = arrow_speed * move_direction

func _physics_process(delta: float) -> void:
	velocity += 5 * delta * get_gravity()
	
	rotation.x = atan(velocity.y/Vector2(velocity.x,velocity.z).length())
	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if area_3d.collision_mask == 2:
		set_physics_process(false)
		area_3d.set_collision_mask_value(3, true)
		area_3d.set_collision_mask_value(2, false)
		return
	
	if body is Player:
		body.pickup_arrow()
		queue_free()
