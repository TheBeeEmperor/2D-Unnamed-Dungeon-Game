extends CharacterBase

var bullet_speed = 2000
var bullet = preload("res://src/Objects/TestBullet.tscn")

func _physics_process(delta):
	var direction = get_direction() 
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		fire()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 	Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - 	Input.get_action_strength("move_up")
	)

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y = speed.y * direction.y
	return out

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)

func kill():
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()
