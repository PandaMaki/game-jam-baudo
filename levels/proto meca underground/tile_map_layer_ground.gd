extends TileMapLayer

@export var largeur: int = 50
@export var hauteur: int = 50
@export var case_depart : Vector2i = Vector2i(25,49)
# Identifiant de la source de ton atlas
@export var source_id: int = 0


# Coordonnées des tuiles dans l'atlas
var tuiles_sol = [
	Vector2i(0, 1),
	Vector2i(1, 1),
]

func _ready():
	get_parent().get_node("Player").global_position = to_global(map_to_local(case_depart))
	generer_carte()
	generer_salle_objectif()

func generer_carte():
	clear()

	for x in range(largeur):
		for y in range(hauteur):
			if case_depart == Vector2i(x,y):
				set_cell(case_depart,source_id,Vector2i(0, 1))
			else :
				generer_case(Vector2i(x, y))

func generer_salle_objectif():
	var coordonée_objectif = Vector2i(randi_range(0,largeur-1),randi_range(0,hauteur-1))
	print(coordonée_objectif)
	var case = coordonée_objectif
	var tuile = Vector2i(0, 0)
	
	set_cell(case,source_id,tuile)

func generer_case(case: Vector2i):
	var nb_aleatoire = randf()
	if nb_aleatoire < 0.30 :
		set_cell(case, source_id, Vector2i(0,1))
	else:
		set_cell(case, source_id, Vector2i(1,1))
	
