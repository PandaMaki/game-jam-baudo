extends Node2D

func _on_player_sol() -> void:
	print("surface")
	$Surface.enabled = true
	$SousSol.enabled = false

func _on_player_sous_sol() -> void:
	await $Player.tween_light.finished
	print("sous sol")
	$Surface.enabled = false
	$SousSol.enabled = true
	
func _on_player_mort() -> void:
	emit_signal("vrai_mort")
