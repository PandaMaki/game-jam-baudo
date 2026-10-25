extends Area2D

@export var speed = 600
var direction = Vector2.ZERO

func _process(delta: float):
	if direction != Vector2.ZERO:
		global_position += speed * delta * direction

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
