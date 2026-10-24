extends CharacterBody2D

@export var speed = 400
@export var acceleration = 40.0
@export var friction = 35.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)
		
	move_and_slide()
