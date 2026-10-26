extends TileMapLayer

@export var largeur: int = 50
@export var hauteur: int = 50
## Position souhaitée du départ : le sol accessible le plus proche sera utilisé
@export var case_depart: Vector2i = Vector2i(25, 49)
@export var source_id: int = 0

@export_group("Génération")
@export_range(0.3, 0.6) var proba_mur_initiale: float = 0.45
@export var iterations_lissage: int = 5
## Part minimale de sol dans la grotte, sinon on régénère
@export_range(0.2, 0.6) var ratio_sol_minimum: float = 0.3
@export var tentatives_max: int = 30

@export_group("Tuiles (coordonnées dans l'atlas)")
@export var tuile_sol: Vector2i = Vector2i(0, 1)
@export var tuile_mur: Vector2i = Vector2i(1, 1)
@export var tuile_objectif: Vector2i = Vector2i(0, 0)



const DIRS_4 := [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

var murs: Array = []            # murs[x][y] == true -> mur
var zone_principale: Array = [] # cases de sol de la grande zone connectée


func _ready() -> void:
	randomize()
	generer_carte()

	var depart := trouver_depart()
	var distances := calculer_distances(depart)
	var objectif := choisir_objectif(distances)

	set_cell(objectif, source_id, tuile_objectif)
	placer_joueur(depart)
	print("Départ : ", depart, " | Objectif : ", objectif)
	
	var taille := tile_set.tile_size
	$"../Player/Camera2D".limit_left = -epaisseur_cadre * taille.x
	$"../Player/Camera2D".limit_top = -epaisseur_cadre * taille.y
	$"../Player/Camera2D".limit_right = (largeur + epaisseur_cadre) * taille.x
	$"../Player/Camera2D".limit_bottom = (hauteur + epaisseur_cadre) * taille.y
	


# ------------------------------------------------------------------
#  GÉNÉRATION
# ------------------------------------------------------------------
func generer_carte() -> void:
	for tentative in tentatives_max:
		initialiser_grille()
		for i in iterations_lissage:
			lisser()
		zone_principale = plus_grande_zone()
		if zone_principale.size() >= largeur * hauteur * ratio_sol_minimum:
			break

	# On rebouche tout ce qui n'est pas dans la zone principale
	initialiser_murs_pleins()
	for case in zone_principale:
		murs[case.x][case.y] = false

	dessiner()


func initialiser_murs_pleins() -> void:
	murs.clear()
	for x in largeur:
		var colonne := []
		colonne.resize(hauteur)
		colonne.fill(true)
		murs.append(colonne)


func initialiser_grille() -> void:
	initialiser_murs_pleins()
	for x in range(1, largeur - 1):       # bords toujours en mur
		for y in range(1, hauteur - 1):
			murs[x][y] = randf() < proba_mur_initiale


func lisser() -> void:
	var nouvelle: Array = []
	for x in largeur:
		var colonne := []
		colonne.resize(hauteur)
		nouvelle.append(colonne)

	for x in largeur:
		for y in hauteur:
			# Les bords restent toujours des murs
			if x == 0 or y == 0 or x == largeur - 1 or y == hauteur - 1:
				nouvelle[x][y] = true
				continue

			var nb := compter_murs_voisins(x, y)
			if nb > 4:
				nouvelle[x][y] = true
			elif nb < 4:
				nouvelle[x][y] = false
			else:
				nouvelle[x][y] = murs[x][y]
	murs = nouvelle

func compter_murs_voisins(cx: int, cy: int) -> int:
	var total := 0
	for dx in range(-1, 2):
		for dy in range(-1, 2):
			if dx == 0 and dy == 0:
				continue
			var nx := cx + dx
			var ny := cy + dy
			# En dehors de la carte = mur
			if nx < 0 or ny < 0 or nx >= largeur or ny >= hauteur or murs[nx][ny]:
				total += 1
	return total


func plus_grande_zone() -> Array:
	var visitees := {}
	var meilleure: Array = []

	for x in largeur:
		for y in hauteur:
			var depart := Vector2i(x, y)
			if murs[x][y] or visitees.has(depart):
				continue

			# Flood fill
			var zone: Array = []
			var file: Array = [depart]
			visitees[depart] = true
			while not file.is_empty():
				var c: Vector2i = file.pop_back()
				zone.append(c)
				for d in DIRS_4:
					var n: Vector2i = c + d
					if est_sol(n) and not visitees.has(n):
						visitees[n] = true
						file.append(n)

			if zone.size() > meilleure.size():
				meilleure = zone
	return meilleure


func est_sol(c: Vector2i) -> bool:
	return c.x >= 0 and c.y >= 0 and c.x < largeur and c.y < hauteur and not murs[c.x][c.y]


@export var epaisseur_cadre: int = 3

func dessiner() -> void:
	clear()
	# Cadre de murs autour de la carte (cases négatives incluses)
	for x in range(-epaisseur_cadre, largeur + epaisseur_cadre):
		for y in range(-epaisseur_cadre, hauteur + epaisseur_cadre):
			var dans_carte := x >= 0 and y >= 0 and x < largeur and y < hauteur
			if dans_carte:
				set_cell(Vector2i(x, y), source_id, tuile_mur if murs[x][y] else tuile_sol)
			else:
				set_cell(Vector2i(x, y), source_id, tuile_mur)

# ------------------------------------------------------------------
#  DÉPART / OBJECTIF
# ------------------------------------------------------------------
func trouver_depart() -> Vector2i:
	# Sol accessible le plus proche de case_depart
	var meilleur: Vector2i = zone_principale[0]
	var meilleure_dist := INF
	for c in zone_principale:
		var d := Vector2(c - case_depart).length_squared()
		if d < meilleure_dist:
			meilleure_dist = d
			meilleur = c
	return meilleur



func generer_case(case: Vector2i):
	var nb_aleatoire = randf()
	if nb_aleatoire < 0.80 :
		set_cell(case, source_id, Vector2i(0,1))
	else:
		set_cell(case, source_id, Vector2i(1,1))
	

func calculer_distances(depart: Vector2i) -> Dictionary:
	# BFS : distance de marche réelle depuis le départ
	var distances := {depart: 0}
	var file: Array = [depart]
	var i := 0
	while i < file.size():
		var c: Vector2i = file[i]
		i += 1
		for d in DIRS_4:
			var n: Vector2i = c + d
			if est_sol(n) and not distances.has(n):
				distances[n] = distances[c] + 1
				file.append(n)
	return distances


func choisir_objectif(distances: Dictionary) -> Vector2i:
	var dist_max := 0
	for c in distances:
		dist_max = maxi(dist_max, distances[c])

	# Une case au hasard parmi les 20 % les plus éloignées
	var candidats: Array = []
	for c in distances:
		if distances[c] >= dist_max * 0.8:
			candidats.append(c)
	return candidats.pick_random()


func placer_joueur(case: Vector2i) -> void:
	var joueur := get_parent().get_node("Player")
	joueur.global_position = to_global(map_to_local(case))
