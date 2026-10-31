extends Node


func _ready() -> void:
	$game_over.hide()
	$LevelChooser.hide()
	get_tree().paused = true


func _on_menu_commencer() -> void:
	$LevelChooser.show()
	$menu.hide()


func _on_game_over_restart() -> void:
	$game_over.hide()
	get_tree().paused = false

func _on_game_vrai_mort() -> void:
	get_tree().paused = true
	$game_over.show()
	
