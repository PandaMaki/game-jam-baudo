extends CharacterBody2D

class_name player

signal sol
signal sous_sol

signal mort

#taille d'une case
@export var taille_case = 32
# Durée (en secondes) pour glisser d'une case à l'autre
@export var duree_deplacement = 0.08
@export var vie_max = 100
var vie = 100
var position_depart = Vector2.ZERO

func fin():
	get_tree().change_scene_to_file("res://game_over.tscn")

# Vrai pendant l'animation : empêche de lancer un 2e déplacement en même temps
var en_mouvement = false

var tween_light = create_tween()
func animation():
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D , "modulate" , Color.RED , 0.1)
	tween.tween_property($AnimatedSprite2D , "modulate" , Color.WHITE, 0.2)
	$hit.play()
func _ready():
	position_depart = global_position
	var tween = create_tween()
	tween.tween_property($PointLight2D, "texture_scale", 10.0, 0.2)
	$CanvasLayer/barre_de_vie.max_value = vie_max
	$CanvasLayer/barre_de_vie.value = vie

func prendre_degat(degat):
	vie -= degat
	$CanvasLayer/barre_de_vie.value = vie
	animation()
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("kill"):
		die()

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
	emit_signal("mort")
	fin()

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
	tween_light = create_tween()
	tween_light.tween_property($PointLight2D, "texture_scale", 1.0, 0.2)
	sous_sol.emit()
	#on passe a l'animation sous terre
	$AnimatedSprite2D.animation = "sous_terre"
	
	# Le Tween anime une propriété progressivement dans le temps
	var tween_mvt = create_tween()
	# Ici : global_position va de sa valeur actuelle à (actuelle + mouvement)
	tween_mvt.tween_property(self, "global_position", global_position + mouvement, duree_deplacement)
	# On attend la fin de l'animation avant de continuer
	await tween_mvt.finished
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
	sol.emit()
	
	#on passe a l'animation hors de terre
	$AnimatedSprite2D.animation = "sortie_de_terre"

func _process(delta: float) -> void:
	if vie <= 0:
		global_position = position_depart
		die()
		vie = 100
		$CanvasLayer/barre_de_vie.value = vie
