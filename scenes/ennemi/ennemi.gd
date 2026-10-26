extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var cible = null
var dead = false
var balle = preload("res://scenes/balle/balle_ennemi.tscn")
var peut_tirer = true




func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if $visée.is_colliding():
		var touche = $visée.get_collider()
		# On vérifie que l'objet existe encore avant de l'utiliser
		if is_instance_valid(touche) and touche.is_in_group("player") and peut_tirer:
			tirer()
			peut_tirer = false
			$Timer.start()
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
	cible = body
func tirer():
	var new_ball = balle.instantiate()
	var direction = $visée
	new_ball.direction = (cible.global_position - direction.global_position).normalized()
	new_ball.global_position = direction.global_position
	new_ball.rotation = new_ball.direction.angle()
	
	get_tree().current_scene.add_child(new_ball)


func _on_timer_timeout() -> void:
	peut_tirer = true
