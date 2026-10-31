extends Node2D

var balle = preload("res://scenes/balle/flamme.tscn")
var flammes : Array[Area2D] = []
var supprimer = false
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not flammes.is_empty() and supprimer:
		var vieille = flammes[0]
		$flamme.play()
		if is_instance_valid(vieille):
			vieille.queue_free()
			flammes.remove_at(0)
			supprimer = false

func shoot():
	var new_ball = balle.instantiate()
	var direction = $RayCast2D
	var cible = direction.to_global(direction.target_position)
	new_ball.direction = (cible - direction.global_position).normalized()
	new_ball.global_position = direction.global_position
	new_ball.rotation = new_ball.direction.angle()
	get_tree().current_scene.add_child(new_ball)
	flammes.append(new_ball)




func _on_timer_timeout() -> void:
	supprimer = true
