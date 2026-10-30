extends CanvasLayer

var instance_jeu = null

const LEVEL_1 = preload("res://levels/level_1.tscn")
const INTRODUCTION = preload("res://scenes/introduction/introduction.tscn")


func _on_level_1_button_pressed():
	instance_jeu = LEVEL_1.instantiate()
	get_tree().root.add_child(instance_jeu)
	
	get_tree().current_scene = instance_jeu
	get_tree().paused = false
	
	queue_free()

func _on_introduction_button_pressed():
	instance_jeu = INTRODUCTION.instantiate()
	get_tree().root.add_child(instance_jeu)
	
	hide()
	get_tree().current_scene = instance_jeu
	
	get_tree().paused = false
