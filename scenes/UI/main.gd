extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$game.hide()
	$game_over.hide()
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_commencer() -> void:
	$game.show()
	$menu.hide()
	get_tree().paused = false


func _on_game_over_restart() -> void:
	$game_over.hide()
	get_tree().paused = false
	$game.show()


func _on_game_vrai_mort() -> void:
	$game.hide()
	get_tree().paused = true
	$game_over.show()
