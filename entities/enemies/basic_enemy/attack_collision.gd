class_name AttackCollision extends StaticBody3D

@export var damage_amount: int = 5

var has_hit: bool = false
var frame_counter: int = 0

signal finished_attack()

func _ready() -> void:
	set_physics_process(false)

func start_attack(starting_angle: float) -> void:
	set_has_hit(false)
	rotation.y = starting_angle + PI/3
	set_collision_layer_value(5, true)
	visible = true
	set_physics_process(true)

func end_attack() -> void:
	frame_counter = 0
	set_collision_layer_value(5, false)
	visible = false
	set_physics_process(false)
	finished_attack.emit()

func set_has_hit(value: bool) -> void:
	has_hit = value

func _physics_process(delta: float) -> void:
	rotation.y -= (4 * PI/3) * delta
	
	frame_counter += 1
	if frame_counter == 30:
		end_attack()
