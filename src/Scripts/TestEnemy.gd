extends KinematicBody2D

onready var _agent: = $NavigationAgent2D
onready var _detection_ray: = $PlayerDetectionRay
onready var _timer: = $Timer
onready var _detection_stop_timer = $DetectionStopTimer
onready var _sprite: = $Sprite

export var health: = 30
export var speed: = 100
var _player = null
var _stop = false
var _velocity: = Vector2.ZERO

func _ready():
	_update_pathfinding()
	_detection_stop_timer.connect("timeout", self, "_stop_pathfinding")
	_timer.connect("timeout", self, "_update_pathfinding")

func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	if Player._hp <= 0:
		_stop = true
		_stop_pathfinding()

	if _agent.is_navigation_finished():
		return
	
	_detection_ray.look_at(Player.position)
	if _detection_ray.is_colliding():
		if _detection_ray.get_collider().is_in_group("Player"):
			_player = _detection_ray.get_collider()
			_detection_ray.cast_to.x = 250
			_stop = false
		else:
			if not _stop:
				_detection_stop_timer.start()
				_stop = true
	else:
		if not _stop:
			_detection_stop_timer.start()
			_stop = true
	
	if _player:
		var direction: = global_position.direction_to(_agent.get_next_location())
		
		var desired_velocity: = direction * speed
		var steering = (desired_velocity - _velocity) * delta * 4.0
		_velocity += steering
		_velocity = move_and_slide(_velocity)
		look_at(_player.position)
		
func _update_pathfinding():
	if _player:
		_agent.set_target_location(_player.position)

func _stop_pathfinding():
	if _stop:
		_player = null
		_detection_ray.cast_to.x = 200

func damage(
	damage:int,
	own
):
	if own.is_in_group("Weapon"):
		health -= damage
