extends CharacterBody2D


@onready var player: CharacterBody2D = $"."

@export var speed = 600
@export var acceleration = 40.0
@export var friction = 35.0


@export var taille_case = 80

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("up"):
		player.position -= Vector2(0,50)
	if Input.is_action_just_pressed("down"):
		player.position += Vector2(0,50)
	if Input.is_action_just_pressed("left"):
		player.position -= Vector2(50,0)
	if Input.is_action_just_pressed("right"):
		player.position += Vector2(50,0)

	#Système de déplacement libre

	#var direction = Vector2.ZERO
	#direction.x = Input.get_axis("left", "right")
	#direction.y = Input.get_axis("up", "down")
	
	#direction = direction.normalized()
	
	#if direction != Vector2.ZERO:
		#velocity = velocity.move_toward(direction * speed, acceleration)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, friction)
		
	#move_and_slide()
	

func _unhandled_input(event: InputEvent) -> void:
	#Système de déplacement en grille
	if Input.is_action_just_pressed("up"):
		position.y -= taille_case
	if Input.is_action_just_pressed("down"):
		position.y += taille_case
