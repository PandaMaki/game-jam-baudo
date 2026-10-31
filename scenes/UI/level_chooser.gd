extends CanvasLayer


var instance_jeu = null

const LEVEL_1 = preload("res://levels/level_1.tscn")
const ARCADE = preload("res://levels/level_prototype2/prototype_meca_sous_terre.tscn")
const INTRODUCTION = preload("res://scenes/introduction/introduction.tscn")


func _on_level_1_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
	
func _on_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_introduction_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/introduction/introduction.tscn")
	

func _on_arcade_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_prototype2/prototype_meca_sous_terre.tscn")


func _on_retour_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main.tscn")


func _on_level_3_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_3.tscn")


func _on_level_4_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_4.tscn")


func _on_level_5_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_5.tscn")
