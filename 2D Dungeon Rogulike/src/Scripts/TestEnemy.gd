extends KinematicBody2D

export var health: = 30
export var speed: = 100
var motion: = Vector2.ZERO
var player = null

func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	if player:
		motion = position.direction_to(player.position)*speed
		look_at(player.position)
	else:
		motion = Vector2.ZERO
	motion = move_and_slide(motion)

func damage(damage: int):
	health -= damage

func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Player"):
		player = body

func _on_Area2D_body_exited(body):
	if body == get_parent().get_node("Player"):
		player = null
