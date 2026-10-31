extends CanvasLayer

var level_chooser_scene = preload("res://scenes/UI/level_chooser.tscn")

func _ready():
	await changement_et_fondu("Il était une fois, Maman Taupe.")
	await changement_et_fondu("Elle a faim.")
	await changement_et_fondu("Creuse, creuse...")
	await changement_et_fondu("Elle sent une odeur...")
	await changement_et_fondu("...De vers de terre! son miam miam préféré.")
	await changement_et_fondu("Mais arrivée, elle découvre un truc machin \n anti-taupe!")
	await changement_et_fondu("--Pourquoi nous faire ça? se dit-elle.")
	await changement_et_fondu("--À croire que ces grandes jambes\n de surface ne nous aiment pas...")
	await changement_et_fondu("Mais elle sens une odeur plus forte!")
	await changement_et_fondu("Creuse Creuse Creuse!!!")
	await changement_et_fondu("Arrivée, elle vois un tas de vers, avec à coté... \n sa fille!")
	await changement_et_fondu("--Hein? AAAA!!! Maman!! cria Taupinette.")
	await changement_et_fondu("Oh! Coucou taupinette!")
	await changement_et_fondu("--Ne regarde pas!! C'est ton cadeau de fête des mères!")
	await changement_et_fondu('"CLAP!" "CLING", Dans sa précipitation, Taupinette\nfrappe Maman taupe...')
	await changement_et_fondu("Et ses lunette sont cassés")
	await changement_et_fondu("--AAh! Non! mes lunettes! Je ne vois rien...")
	await changement_et_fondu("--Désolé Maman, j'a pas fait exprès!!")
	await changement_et_fondu("Pour trouver des lunette, Maman taupe,\n que vous incarnez doit les chercher dans...")
	await changement_et_fondu("La grotte aux lunettes! protégé par\nles gardiens des lunettes!")
	await changement_et_fondu("Déplacez vous avec zqsd ou les flèches, quand\n vous êtes imobiles, vous êtes a la surface, mais\nune fois que vous bougez, vous êtes sous terre", 3.5)
	await changement_et_fondu("Sous la surface, vous pouvez passer sous\n certains murs et trouver la sortie,\n mais vous ne voyez quasi rien.", 3)
	await changement_et_fondu("appuyez sur K si vous êtes bloqué.")
	
	get_tree().change_scene_to_file("res://scenes/UI/level_chooser.tscn")
	
func changement_et_fondu(texte, duree = 1.5):
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 0.5)
	tween.tween_interval(duree)
	%LabelTexte.text = texte
	tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)
	await tween.finished
	
