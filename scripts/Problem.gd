extends Control

var tiempo_restante := 60

func _ready():
	cargar_pregunta(GameManagerInstance.current_row)
	print("✅ _ready ejecutado")

func cargar_pregunta(row: Dictionary):
	# Actualiza contenido del problema
	$LBL_PROBLEMA.text = row.get("ProblemaDescripcion", "Sin descripción")
	$LBL_RESOLUCION.text = ""
	$LBL_METODO.text = "Método: %s" % row.get("Metodo", "")
	$LBL_DIFICULTAD.text = "Dificultad: %s" % row.get("Dificultad", "")
	$LBL_PUNTAJE.text = "Puntos: %d" % GameManagerInstance.score

	# Prepara entrada
	$LINE_EDIT_RESPUESTA.text = ""
	$LINE_EDIT_RESPUESTA.editable = true
	$BTN_VALIDAR.disabled = true

	# Reinicia el tiempo
	tiempo_restante = 60
	update_timer_display()

	# Reinicia TimerProblema (cuenta atrás lógica)
	$TimerProblema.stop()
	$TimerProblema.wait_time = 60
	$TimerProblema.one_shot = true
	$TimerProblema.start()

	# Reinicia TimerVisual (actualiza pantalla)
	$TimerVisual.stop()
	$TimerVisual.wait_time = 1
	$TimerVisual.one_shot = false
	$TimerVisual.start()

	print("🎯 TimerVisual iniciado - running?:", !$TimerVisual.is_stopped())

func update_timer_display():
	$LBL_TIEMPO.text = "Tiempo: %ds" % tiempo_restante
	if tiempo_restante <= 10:
		$LBL_TIEMPO.add_theme_color_override("font_color", Color.RED)
	else:
		$LBL_TIEMPO.add_theme_color_override("font_color", Color.BLUE)

func _on_TimerVisual_timeout():
	print("💡 Señal TimerVisual activada")
	if tiempo_restante > 0:
		tiempo_restante -= 1
		update_timer_display()
		print("⏱ Quedan %d segundos" % tiempo_restante)
	else:
		_on_TimerProblema_timeout()

func _on_TimerProblema_timeout():
	$BTN_VALIDAR.disabled = true
	$LINE_EDIT_RESPUESTA.editable = false
	$LBL_TIEMPO.text = "¡Tiempo agotado!"
	$LBL_TIEMPO.add_theme_color_override("font_color", Color.RED)
	$TimerVisual.stop()

func _on_line_edit_respuesta_text_changed(new_text):
	$BTN_VALIDAR.disabled = new_text.strip_edges() == ""

func _on_btn_validar_pressed():
	if !$LINE_EDIT_RESPUESTA.editable:
		return

	var respuesta_usuario = $LINE_EDIT_RESPUESTA.text.strip_edges()
	var respuesta_correcta = GameManagerInstance.current_row.get("Respuesta", "").strip_edges()

	if respuesta_usuario == respuesta_correcta:
		GameManagerInstance.score += 10
		$LBL_PUNTAJE.text = "Puntos: %d" % GameManagerInstance.score
	else:
		$LBL_PUNTAJE.text = "Incorrecto. Puntos: %d" % GameManagerInstance.score

	$LBL_RESOLUCION.text = respuesta_correcta
	$BTN_VALIDAR.disabled = true
	$LINE_EDIT_RESPUESTA.editable = false

	$TimerProblema.stop()
	$TimerVisual.stop()

func _on_btn_siguiente_pressed():
	GameManagerInstance.advance_to_next()
	cargar_pregunta(GameManagerInstance.current_row)
