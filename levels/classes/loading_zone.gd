extends Area3D

@export var next_scene: StringName = &""

func _on_body_entered(body: Node3D) -> void:
	body.save_info
	SceneLoader.load_scene(next_scene)
