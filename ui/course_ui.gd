class_name CourseUi extends CanvasLayer

@onready var stroke_counter: Label = %StrokeCounter

var curr_stroke_count: int = 0

func _ready() -> void:
	stroke_counter.set_text(str(curr_stroke_count))

func update_strokes(amount_added: int) -> void:
	#play diff animations based on stroke count change
	
	curr_stroke_count += amount_added
	
	stroke_counter.set_text(str(curr_stroke_count))
