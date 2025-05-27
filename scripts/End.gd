extends Control

func _ready():
	$LBL_PUNTAJE_FINAL.text = "Tu puntaje final es: %d" % GameManagerInstance.score

func _on_btn_reiniciar_pressed():
	GameManagerInstance.score = 0
	GameManagerInstance.current = 0
	GameManagerInstance.current_row = {}

	get_tree().change_scene_to_file("res://scripts/Start.tscn")
