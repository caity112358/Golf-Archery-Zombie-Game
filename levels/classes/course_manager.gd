class_name CourseManager extends Node

@export var player: Player
@export var enemies: Array[Entity]
@export var course_ui: CourseUi
@export var course_node: CourseNode

var stroke_count: int = 0

func _ready() -> void:
	player.stroke_added.connect(on_stroke_added)
	course_node.node_destroyed.connect(end_level)
	for enemy in enemies:
		player.sound_made.connect(enemy.on_hear_sound)

func on_stroke_added(amount_added: int) -> void:
	stroke_count += amount_added
	course_ui.update_strokes(amount_added)

func end_level() -> void:
	SceneLoader.load_scene(Constants.SCENE_PATHS.level_select)
