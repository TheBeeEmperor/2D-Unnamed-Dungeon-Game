extends Node2D

onready var animation = $AnimationPlayer

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		animation.play("Swipe")
