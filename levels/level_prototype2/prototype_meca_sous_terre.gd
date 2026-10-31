extends Node2D

var sous_terre : bool = false
var can_dig : bool = false
var under_rock : bool = false
var point_sonar = 2
var able = true

@onready var player: player = $Player
@onready var point_light_2d: PointLight2D = $Player/PointLight2D
@onready var carte_vue_sous_terre: TileMapLayer = $VueSousTerre
@onready var carte_vue_sur_terre: TileMapLayer = $VueSurTerre
@onready var sonar_light: PointLight2D = $Player/PointLight2D2
@onready var sonar_restant: Label = $Player/SonarRestant
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Player/AudioStreamPlayer2D



func _ready() -> void:
	audio_stream_player_2d.play()
	point_light_2d.visible = true
	carte_vue_sur_terre.visible = true
	carte_vue_sous_terre.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		if sous_terre:
			if under_rock:
				return
			# Remonter
			player.collision_layer = 1
			player.collision_mask = 1
			sous_terre = false
			point_light_2d.visible = true
			carte_vue_sous_terre.visible = false
			carte_vue_sur_terre.visible = true
			
		elif can_dig:
			# Descendre
			player.collision_layer = 2
			player.collision_mask = 2
			sous_terre = true
			point_light_2d.visible = false
			carte_vue_sur_terre.visible = false
			carte_vue_sous_terre.visible = true
	if Input.is_action_just_pressed("sonar"):
		if point_sonar > 0 :
			if sous_terre :
				sonar_zone_activation()
				point_sonar -= 1
	sonar_restant.text = str(point_sonar)


func _on_zone_dig_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_dig = true
		print("can dig")
func _on_zone_dig_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_dig = false
		print("cant dig")

func _on_zone_pierre_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		under_rock = true
		print("under rock")
func _on_zone_pierre_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		under_rock = false
		print("not under rock")
func sonar_zone_activation():
	for i in range(10):
		sonar_light.texture_scale += 1
		await get_tree().create_timer(0.2).timeout
	if sonar_light.texture_scale == 11 :
		sonar_light.texture_scale = 1

func _on_zone_sonar_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if able:
			point_sonar = 2
			able = false
