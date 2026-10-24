extends CharacterBody2D

@onready var player: CharacterBody2D = $"."

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		player.position -= Vector2(0,50)
	if Input.is_action_just_pressed("down"):
		player.position += Vector2(0,50)
	if Input.is_action_just_pressed("left"):
		player.position -= Vector2(50,0)
	if Input.is_action_just_pressed("right"):
		player.position += Vector2(50,0)
