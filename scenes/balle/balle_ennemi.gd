extends Area2D

@export var speed = 400
var direction = Vector2.ZERO

func _process(delta: float):
	if direction != Vector2.ZERO:
		global_position += speed * delta * direction

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
			# 1. Si c'est l'enemi, on ignore
	if body.name.to_lower() == "ennemi":
		return
	
	# 2. Si c'est l'ennemi, on le tue et on détruit la balle
	if body is player:
		body.prendre_degat(25) # Va activer le queue_free() de l'ennemi
		print("ennemi est mort")
		queue_free() # Détruit la balle
		print("balle détruite")
