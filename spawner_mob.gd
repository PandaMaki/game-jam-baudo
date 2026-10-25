extends Node2D
@export var ennemi_scene : PackedScene
var game = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_parent()
	spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn():
	var ennemi = ennemi_scene.instantiate()
	ennemi.global_position = $Marker2D.global_position
	game.add_child.call_deferred(ennemi)
	
