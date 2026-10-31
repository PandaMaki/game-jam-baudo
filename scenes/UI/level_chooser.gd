extends CanvasLayer

var instance_jeu = null

const LEVEL_1 = preload("res://levels/level_1.tscn")
const LEVEL_2 = preload("res://levels/level_prototype2/prototype_meca_sous_terre.tscn")
const INTRODUCTION = preload("res://scenes/introduction/introduction.tscn")


func _on_level_1_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_prototype2/prototype_meca_sous_terre.tscn")

func _on_introduction_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/introduction/introduction.tscn")


func _on_retour_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/main.tscn")
