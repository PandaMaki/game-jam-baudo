extends CanvasLayer

var instance_jeu = null

const LEVEL_PROTYPE_2 = preload("res://levels/level_prototype2/level_prototype_2.tscn")
const LEVEL_PROTYPE = preload("res://levels/level_prototype.tscn")


func _on_prototype_2_level_button_pressed():
	instance_jeu = LEVEL_PROTYPE_2.instantiate()
	get_tree().root.add_child(instance_jeu)
	
	hide()
	get_tree().paused = false
	get_node("../game/Player").queue_free()


func _on_prototype_level_button_pressed():
	instance_jeu = LEVEL_PROTYPE.instantiate()
	get_tree().root.add_child(instance_jeu)
	
	hide()
	get_tree().paused = false
	get_node("../game/Player").queue_free()
