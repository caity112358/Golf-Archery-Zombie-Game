extends EntityState

@export var chase_state: EntityState
@export var attack_collision: AttackCollision

var enemy: Enemy :
	get(): return entity as Enemy

#entering plays an animation that spawns and moves a hitbox. 
	#could call entity.attack() as well potentially
#transitions back into chase
func enter_state() -> void:
	enemy.attack()
	await attack_collision.finished_attack
	switch_state.emit(chase_state)

func movement_direction(_delta: float) -> Vector3:
	return Vector3.FORWARD
