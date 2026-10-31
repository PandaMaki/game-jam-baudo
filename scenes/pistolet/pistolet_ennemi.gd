extends Node2D


# Called when the node enters the scene tree for the first time.
var balle = preload("res://scenes/balle/balle_ennemi.tscn")
@onready var directions : Array[RayCast2D] = [$Node2D/Canon1 , $Node2D/Canon2 , $Node2D/Canon3]
var directions_utilisé : Array[RayCast2D] = []
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot():
	var new_ball = balle.instantiate()
	var direction = $RayCast2D
	var cible = direction.to_global(direction.target_position)
	new_ball.direction = (cible - direction.global_position).normalized()
	new_ball.global_position = direction.global_position
	new_ball.rotation = new_ball.direction.angle()
	get_tree().current_scene.add_child(new_ball)
	$shoot.play()
