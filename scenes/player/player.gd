extends CharacterBody2D

@export var taille_case = 80

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		essayer_deplacer(Vector2.UP)
	elif event.is_action_pressed("down"):
		essayer_deplacer(Vector2.DOWN)
	elif event.is_action_pressed("left"):
		essayer_deplacer(Vector2.LEFT)
	elif event.is_action_pressed("right"):
		essayer_deplacer(Vector2.RIGHT)

func essayer_deplacer(dir: Vector2) -> void:
	var mouvement = dir * taille_case
	# test_move renvoie true s'il y a une collision sur ce trajet
	if not test_move(global_transform, mouvement):
		global_position += mouvement
