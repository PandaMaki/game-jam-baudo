extends Node2D

var balle = preload("res://scenes/balle/balle_minigun.tscn")
@onready var directions : Array[RayCast2D] = [$Node2D/Canon1 , $Node2D/Canon2 , $Node2D/Canon3]
var directions_utilisé : Array[RayCast2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_path())
	print(get_children())
	print($Node2D.get_children())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot():
	var new_ball = balle.instantiate()
	var direction = directions.pick_random()
	while directions_utilisé.has(direction):
		direction = directions.pick_random()
	var cible = direction.to_global(direction.target_position)
	new_ball.direction = (cible - direction.global_position).normalized()
	new_ball.global_position = direction.global_position
	new_ball.rotation = new_ball.direction.angle()
	get_tree().current_scene.add_child(new_ball)
	directions_utilisé.append(direction)
	directions_utilisé.clear()
