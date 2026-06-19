extends Button

@export var scene_path: StringName = &""

func _on_pressed() -> void:
	SceneLoader.load_scene(scene_path)
