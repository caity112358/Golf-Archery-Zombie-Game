extends MeshInstance3D

@onready var material: StandardMaterial3D = get_surface_override_material(0) as StandardMaterial3D

var frame_counter: int = 0
func _physics_process(delta: float) -> void:
	frame_counter += 1
	material.albedo_color = Color(
		0.5 + 0.5 * cos((frame_counter * delta)), 
		0.5 + 0.5 * cos((frame_counter * delta) + 2 * PI / 3), 
		0.5 + 0.5 * cos((frame_counter * delta) + 4 * PI/ 3),
		0.5 + 0.5 * cos((frame_counter * delta) / 10)
		)
