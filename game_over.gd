extends CanvasLayer
signal restart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/level_chooser.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/main.tscn")
