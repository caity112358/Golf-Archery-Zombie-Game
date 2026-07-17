class_name Enemy extends Entity

@onready var attack_collision: AttackCollision = $AttackCollision

func on_hear_sound(sound_volume: Constants.sound_volume, sound_position: Vector3) -> void:
	if can_hear_sound(sound_volume, sound_position):
		state_machine.investigate_sound(sound_position)

func can_hear_sound(sound_volume: Constants.sound_volume, sound_position: Vector3) -> bool:
	if (
		sound_volume == Constants.sound_volume.QUIET_SOUND 
		and (sound_position - global_position).length() < 10
	):
		return true
	
	if (
		sound_volume == Constants.sound_volume.LOUD_SOUND 
		and (sound_position - global_position).length() < 20
	):
		return true
	
	return false

func kill_enemy() -> void:
	self.queue_free()

func attack() -> void:
	attack_collision.start_attack(model.rotation.y)
