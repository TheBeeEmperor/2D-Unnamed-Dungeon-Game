class_name MeleeWeapon
extends RigidBody2D

onready var animPlayer: = $AnimationPlayer
onready var hitbox: = $Sprite/HitBox

export var damage: = 10

func _ready():
	hitbox.damage = damage

func _process(delta):
	if Input.is_action_just_pressed("melee_attack"):
		animPlayer.play("Attack")
	
	if Input.is_action_just_pressed("ability_use"):
		animPlayer.play("Ability")
		ability()

func ability():
	pass
