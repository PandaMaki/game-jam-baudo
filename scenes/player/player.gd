extends CharacterBody2D

@export var taille_case = 80

# Durée (en secondes) pour glisser d'une case à l'autre
@export var duree_deplacement = 0.12

# Vrai pendant l'animation : empêche de lancer un 2e déplacement en même temps
var en_mouvement = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		essayer_deplacer(Vector2.UP)
	elif event.is_action_pressed("down"):
		essayer_deplacer(Vector2.DOWN)
	elif event.is_action_pressed("left"):
		essayer_deplacer(Vector2.LEFT)
	elif event.is_action_pressed("right"):
		essayer_deplacer(Vector2.RIGHT)


func die():
	queue_free()

func essayer_deplacer(dir: Vector2) -> void:
	var mouvement = dir * taille_case
	# test_move simule le déplacement sans le faire.
	# Renvoie true si un mur (ou autre corps) bloque le trajet.
	if test_move(global_transform, mouvement):
		return  # Mur : on annule, le perso ne bouge pas
	# Pas d'obstacle : on lance le déplacement
	en_mouvement = true
	# Le Tween anime une propriété progressivement dans le temps
	var tween = create_tween()
	# Ici : global_position va de sa valeur actuelle à (actuelle + mouvement)
	tween.tween_property(self, "global_position", global_position + mouvement, duree_deplacement)
	# On attend la fin de l'animation avant de continuer
	await tween.finished
	# Animation finie : le perso peut de nouveau bouger
	en_mouvement = false
	
func mecanique():
	pass
