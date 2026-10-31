extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var cible = null
var dead = false
var balle = preload("res://scenes/balle/balle_ennemi.tscn")
var peut_tirer = true
var vie = 250

func animation():
	var tween = create_tween()
	tween.tween_property($Sprite2D , "modulate" , Color.RED , 0.1)
	tween.tween_property($Sprite2D , "modulate" , Color.WHITE, 0.2)
	$hit.play()
func prendre_degat(degat):
	vie -= degat
	animation()



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if vie <= 0:
		die()
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if $visée.is_colliding():
		var touche = $visée.get_collider()
		if touche != null and touche.is_in_group("player"):
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			$lance_flamme.shoot()
			peut_tirer = false
			$Timer.start()
			print("Timer démarré : ", $Timer.time_left)
	if cible != null:
		look_at(cible.global_position)
		$NavigationAgent2D.target_position = cible.global_position
		var direction_mouvement = $NavigationAgent2D.get_next_path_position()
		var direction_jsp = direction_mouvement -global_position
		var direction_normalisé = direction_jsp.normalized()
		if direction_normalisé != Vector2.ZERO:
			velocity = direction_normalisé*SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	move_and_slide()

func die():
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		cible = body
