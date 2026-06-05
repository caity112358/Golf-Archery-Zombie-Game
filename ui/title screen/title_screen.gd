extends Control

func _on_button_pressed() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.level_select)
