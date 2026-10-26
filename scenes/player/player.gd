extends CharacterBody2D

#taille d'une case

class_name player

@export var taille_case = 32
# Durée (en secondes) pour glisser d'une case à l'autre
@export var duree_deplacement = 0.08

# Vrai pendant l'animation : empêche de lancer un 2e déplacement en même temps
var en_mouvement = false

func _ready():
	#lumière allumée
	var tween = create_tween()
	tween.tween_property($PointLight2D, "texture_scale", 10.0, 0.2)

func _unhandled_input(event: InputEvent) -> void:
	if en_mouvement:
		return
	
	if event.is_action_pressed("up"):
		essayer_deplacer(Vector2.UP)
	elif event.is_action_pressed("down"):
		essayer_deplacer(Vector2.DOWN)
	elif event.is_action_pressed("left"):
		essayer_deplacer(Vector2.LEFT)
		$AnimatedSprite2D.flip_h = true
	elif event.is_action_pressed("right"):
		essayer_deplacer(Vector2.RIGHT)
		$AnimatedSprite2D.flip_h = false

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
	
	#on va sous terre
	$TimerNoir.stop()
	var tween = create_tween()
	tween.tween_property($PointLight2D, "texture_scale", 1.0, 0.2)
	#on passe a l'animation sous terre
	$AnimatedSprite2D.animation = "sous_terre"
	
	# Le Tween anime une propriété progressivement dans le temps
	tween = create_tween()
	# Ici : global_position va de sa valeur actuelle à (actuelle + mouvement)
	tween.tween_property(self, "global_position", global_position + mouvement, duree_deplacement)
	# On attend la fin de l'animation avant de continuer
	await tween.finished
	# Animation finie : le perso peut de nouveau bouger
	en_mouvement = false
	
	#on sort de terre
	$TimerNoir.start()

#on sort de terre
func _on_timer_noir_timeout() -> void:
	if en_mouvement:
		return
	var tween = create_tween()
	tween.tween_property($PointLight2D, "texture_scale", 10.0, 0.5)
	
	#on passe a l'animation hors de terre
	$AnimatedSprite2D.animation = "sortie_de_terre"
