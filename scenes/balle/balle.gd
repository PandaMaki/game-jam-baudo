extends Area2D

@export var speed = 600

func _process(delta: float):
	global_position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
