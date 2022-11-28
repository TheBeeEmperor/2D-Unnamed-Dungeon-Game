extends KinematicBody2D

export var _speed: = 300
export var _hp: = 100
var _hpsave = _hp

var _velocity: = Vector2.ZERO
var start_pos = position

func _process(delta):
	if _hp <= 0:
		_hp = _hpsave
		position = start_pos

func _physics_process(delta):
	var _direction: = get_direction() 
	_velocity = calculate_move_velocity(_velocity, _direction, _speed)
	_velocity = move_and_slide(_velocity)
	look_at(get_global_mouse_position())

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 	Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - 	Input.get_action_strength("move_up")
	)

func damage(
	_damage: int,
	own
):
	if own.is_in_group("Enemy"):
		_hp -= _damage
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: int
) -> Vector2:
	var _out: = linear_velocity
	_out.x = speed * direction.x
	_out.y = speed * direction.y
	return _out
