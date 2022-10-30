extends Node2D

onready var _timer = $Timer

export(PackedScene) var _object
export var _delay_range: = [1,5]
export var _object_limit: = 20
export var _radius:float = 500
var _spawned_objects: = 0

func _ready():
	_timer.wait_time = rand_range(_delay_range[0],_delay_range[1])
	_spawn()
	_timer.start()
	_timer.connect("timeout", self, "_spawn")

func _spawn():
	if _spawned_objects < _object_limit:
		var spawningObject = _object.instance()
		spawningObject.position = Vector2(rand_range(0,_radius),rand_range(0,_radius))
		var cast = RayCast2D.new()
		cast.position = spawningObject.position
		cast.name = "RayCast"
		cast.cast_to.x = 1
		add_child(cast)
		if cast.is_colliding():
			remove_child(cast)
			cast.queue_free()
			_spawn()
			return
		remove_child(cast)
		cast.queue_free()
		_spawned_objects += 1
		get_parent().call_deferred("add_child",spawningObject)
		_timer.wait_time = rand_range(_delay_range[0],_delay_range[1])
		_timer.start()
