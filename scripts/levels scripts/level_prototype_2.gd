extends Node2D


func _on_player_sol() -> void:
	$Sol.enabled = true
	$Sol2.enabled = false

func _on_player_sous_sol() -> void:
	$Sol2.enabled = true
	$Sol.enabled = false
