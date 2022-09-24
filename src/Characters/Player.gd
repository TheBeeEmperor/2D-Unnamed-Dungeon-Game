extends CharacterBase

func _physics_process(delta):
	var direction: = get_direction() 
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 	Input.get_action_strength("move_left"),
		Input.get_action_strength("move_up") - 	Input.get_action_strength("move_down")
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	return out
