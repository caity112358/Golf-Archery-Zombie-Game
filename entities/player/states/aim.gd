extends State

@export var idle_state: State

func enter_state() -> void:
	print("entered aim")
	
	#get control of camera

func update(_delta: float) -> void:
	#pull back bow and zoom in if left click is held down
	#zoom out, emit switch_state(idle_state) and spawn the arrow moving if left 
	#click is let go
	
	pass
