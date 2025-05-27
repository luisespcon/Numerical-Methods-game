extends Control

func _on_btn_iniciar_pressed():
	var metodo = GameManagerInstance.methods[0]  # Primer método: "Bisección"
	var dificultad = ["Alta", "Baja"].pick_random()

	var query = "SELECT idProblema, Metodo, Dificultad, ProblemaDescripcion, Respuesta FROM Questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1"
	GameManagerInstance.db.query_with_bindings(query, [metodo, dificultad])
	var rows = GameManagerInstance.db.query_result

	if rows.size() > 0:
		GameManagerInstance.current_row = rows[0]
		GameManagerInstance.current = 0  # Reinicia el índice de métodos
		get_tree().change_scene_to_file("res://scripts/Problem.tscn")
	else:
		push_error("❌ No se encontró un problema para '%s' con dificultad '%s'" % [metodo, dificultad])

func _ready():
	pass
