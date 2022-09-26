extends KinematicBody2D

export var speed: = 300
export var hp: = 100

var _velocity: = Vector2.ZERO

func _process(delta):
	if hp <= 0:
		get_tree().reload_current_scene()

func _physics_process(delta):
	var direction: = get_direction() 
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity)
	look_at(get_global_mouse_position())

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 	Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - 	Input.get_action_strength("move_up")
	)

func damage(damage: int):
	hp -= damage
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: int
) -> Vector2:
	var out: = linear_velocity
	out.x = speed * direction.x
	out.y = speed * direction.y
	return out
