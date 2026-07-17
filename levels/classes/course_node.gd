class_name CourseNode extends Area3D

signal node_destroyed

func _on_body_entered(body: Node3D) -> void:
	if body is Arrow:
		print("arrow entered")
		node_destroyed.emit()
