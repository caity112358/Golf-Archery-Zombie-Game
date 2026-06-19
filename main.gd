extends Node

func _ready() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.test_scene)
