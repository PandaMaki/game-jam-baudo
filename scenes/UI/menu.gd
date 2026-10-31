extends CanvasLayer
signal commencer


func _on_button_pressed() -> void:
	emit_signal("commencer")


func _on_button_2_button_down() -> void:
	get_tree().quit()


func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_credits_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/credit/crédit.tscn")
