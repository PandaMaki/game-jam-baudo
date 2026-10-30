extends CanvasLayer

var level_chooser_scene = preload("res://scenes/UI/level_chooser.tscn")

func _ready():
	await changement_et_fondu("Gratte... Gratte...")
	await changement_et_fondu("Oh! Je sens...")
	await changement_et_fondu("Une odeur... De vers de terre !")
	await changement_et_fondu("Vite! Gratte...")
	await changement_et_fondu("Arrivée!!!... Quoi?!")
	await changement_et_fondu("Encore un de ces trucs machins anti-taupes?!")
	await changement_et_fondu("Pourquoi nous faire ça?")
	await changement_et_fondu("À croire que ces grandes jambes ne nous aiment pas...")
	await changement_et_fondu("Oh! Mais... Je sens...")
	await changement_et_fondu("Une autre odeur de vers! Plus forte!")
	await changement_et_fondu("Gratte Gratte Gratte !!!")
	await changement_et_fondu("Pleins de vers!!!")
	await changement_et_fondu("-Hein? AAAA!!! Maman!!")
	await changement_et_fondu("Oh! Coucou taupinette!")
	await changement_et_fondu("-Ne regarde pas!!")
	await changement_et_fondu('"CLAP!" "CLING"')
	await changement_et_fondu("AAh! Non! mes lunettes! Je ne vois rien...")
	await changement_et_fondu("-Désolé Maman, c'était ton cadeau de fête des mère...")
	await changement_et_fondu("Pas grave, mais je vais aller me chercher de \n nouvelles lunettes... Dans la grotte aux lunettes !")
	await changement_et_fondu("Il faut que je fasse attention...")
	
	var chooser_instance = level_chooser_scene.instantiate()
	get_tree().root.add_child(chooser_instance)
	get_tree().current_scene = chooser_instance
	
	# On supprime la cinématique de la mémoire
	queue_free()
	
func changement_et_fondu(texte):
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 0.5)
	tween.tween_interval(1.5)
	%LabelTexte.text = texte
	tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)
	await tween.finished
	
