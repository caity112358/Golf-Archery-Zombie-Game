extends Node

func _ready() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.title_screen)
