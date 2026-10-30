extends Node2D

var balle = preload("res://scenes/balle/balle.tscn")

func _process(delta: float):
	look_at(get_global_mouse_position())
	
	if cos(rotation) < 0:
		$Sprite2D.flip_v = true
	else:
		$Sprite2D.flip_v = false
	
func tirer():
	var new_ball = balle.instantiate()
	
	new_ball.global_position = global_position
	new_ball.rotation = rotation
	
	get_tree().current_scene.add_child(new_ball)
	
func _unhandled_input(event: InputEvent):
	if Input.is_action_just_pressed("shoot"):
		tirer()
