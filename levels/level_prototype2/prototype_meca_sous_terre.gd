extends Node2D

var sous_terre : bool = false
@onready var player: player = $Player
@onready var point_light_2d: PointLight2D = $Player/PointLight2D
@onready var carte_vue_sous_terre: TileMapLayer = $VueSousTerre
@onready var carte_vue_sur_terre: TileMapLayer = $VueSurTerre


func _ready() -> void:
	point_light_2d.visible = true
	carte_vue_sur_terre.visible = true
	carte_vue_sous_terre.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		if sous_terre :
			player.collision_layer = 2
			player.collision_mask = 2
			sous_terre = false
			point_light_2d.visible = false
			carte_vue_sous_terre.visible = true
			carte_vue_sur_terre.visible = false
		else :
			player.collision_layer = 1
			player.collision_mask = 1
			sous_terre = true
			point_light_2d.visible = true
			carte_vue_sur_terre.visible = true
			carte_vue_sous_terre.visible = false
