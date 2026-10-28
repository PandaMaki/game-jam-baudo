extends Node2D
@export var ennemi_scene : PackedScene
var game = get_parent()
var ennemies : Array[CharacterBody2D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = get_parent()
	spawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	game.vrai_mort.connect(_on_game_vrai_mort)

func spawn():
	var ennemi = ennemi_scene.instantiate()
	ennemi.global_position = $Marker2D.global_position
	game.add_child.call_deferred(ennemi)
	ennemies.append(ennemi)

func despawn():
	for i in ennemies:
		var tout_le_monde = i
		if tout_le_monde.is_instance_valid():
			queue_free()
	ennemies.clear()
func _on_game_vrai_mort():
	game.vrai_mort.connect(_on_game_vrai_mort)
	despawn()
