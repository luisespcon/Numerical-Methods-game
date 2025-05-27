extends Node
class_name GameManager

var db  # Instancia de SQLite
var current := 0
var current_row := {}
var score := 0


var methods := [
	"Bisección",
	"Diferencias Divididas",
	"Eliminación Gaussiana",
	"Euler Adelantado",
	"Euler Atrás",
	"Euler Modificado",
	"Falsa Posición",
	"Runge-Kutta 3/8",
	"Runge-Kutta Orden Superior",
	"Newton-Cotes Cerradas",
	"Newton-Raphson",
	"Punto Fijo",
	"Simpson 1/3",
	"Simpson 3/8",
	"Regla del Trapecio",
	"Runge-Kutta 4",
	"Secante",
	"Gráfico",
	"Interpolación Lineal",
	"Gauss-Jordán",
	"Gauss-Seidel",
	"Jacobi",
	"Lagrange",
	"Montante",
	"Newton Adelante",
	"Newton Atrás",
	"Newton-Cotes Abiertas",
	"Runge-Kutta 2° Orden",
	"Runge-Kutta 3° Orden"
]

func _ready():
	db = SQLite.new()
	db.path = "res://data/banco.db"
	if not db.open_db():
		push_error("❌ Error al abrir la base de datos.")
	else:
		print("✅ Base de datos abierta correctamente.")
	randomize()


func get_next_problem() -> Dictionary:
	if current >= methods.size():
		return {}

	var metodo = methods[current]
	var dificultad = "Alta" if randi() % 2 == 0 else "Baja"

	var query = "SELECT idProblema, Metodo, Dificultad, ProblemaDescripcion, Respuesta FROM questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1"
	db.query_with_bindings(query, [metodo, dificultad])
	var rows = db.query_result

	if rows.size() > 0:
		current_row = rows[0]
	else:
		current_row = {
			"ProblemaDescripcion": "No hay problema disponible para el método: %s (%s)" % [metodo, dificultad],
			"Respuesta": "Sin respuesta disponible."
		}

	return current_row


func advance_to_next():
	current += 1
	if current >= methods.size():
		get_tree().change_scene_to_file("res://scripts/End.tscn")
		return

	var metodo = methods[current]
	var dificultad = ["Alta", "Baja"].pick_random()
	var query = "SELECT idProblema, Metodo, Dificultad, ProblemaDescripcion, Respuesta FROM Questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1"
	db.query_with_bindings(query, [metodo, dificultad])
	var rows = db.query_result

	if rows.size() > 0:
		current_row = rows[0]
	else:
		current_row = {
			"ProblemaDescripcion": "No hay problema disponible para el método: %s (%s)" % [metodo, dificultad],
			"Respuesta": "Sin respuesta disponible."
		}









#extends Node
#class_name GameManager
#
#var db  # Instancia de SQLite
#var current = 0
#var current_row = {}
#
#var methods = [
	#"Bisectriz", "Diferencias Divididas", "Eliminación Gaussiana",
	#"Euler hacia Adelante", "Euler hacia Atrás", "Euler Modificado",
	#"Falsa Posición (Regula Falsi)", "Gauss-Jordán", "Gauss-Seidel",
	#"Jacobi", "Lagrange", "Montante", "Newton hacia Adelante",
	#"Newton hacia Atrás", "Newton-Cotes Abiertas", "Newton-Cotes Cerradas",
	#"Newton-Raphson", "Punto Fijo (o Sustituciones Sucesivas)",
	#"Regla de 1/3 de Simpson", "Regla de 3/8 de Simpson", "Regla del Trapecio",
	#"Runge-Kutta Cuarto Orden por 1/3 Simpson", "Runge-Kutta Cuarto Orden por 3/8 Simpson",
	#"Runge-Kutta Orden Superior", "Runge-Kutta Segundo Orden",
	#"Runge-Kutta Tercer Orden", "Secante", "Gráfico", "Interpolación Lineal"
#]
#
#func _ready():
	#db = SQLite.new()
	#db.path = "res://data/banco.db"
	#var result = db.open_db()
	#
	#if result == false:
		#push_error("❌ Error al abrir la base de datos.")
	#else:
		#print("✅ Base de datos abierta correctamente.")
#
	#randomize()
#
#
#func get_next_problem() -> Dictionary:
	#if current >= methods.size():
		#return {}
	#
	#var metodo = methods[current]
	#var dificultad = "Alta" if randi() % 2 == 0 else "Baja"
#
	#var rows = db.select_rows(
		#"SELECT ProblemaDescripcion, Respuesta FROM Questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1",
		#[metodo, dificultad]
	#)
#
	#if rows.size() > 0:
		#current_row = rows[0]
	#else:
		#current_row = {
			#"ProblemaDescripcion": "No hay problema disponible",
			#"Respuesta": "Sin respuesta"
		#}
#
	#return current_row
#
#
#func advance_to_next():
	#current += 1
	#if current >= methods.size():
		#get_tree().change_scene("res://scripts/End.tscn")
	#else:
		#get_tree().change_scene("res://scripts/Problem.tscn")











#extends Node
#class_name GameManager
#
#var db  # Conexión a la base de datos
#var current = 0  # Índice actual del método
#var current_row = {}  # Diccionario con el problema actual
#
## Lista de métodos numéricos
#var methods = [
	#"Bisectriz",
	#"Diferencias Divididas",
	#"Eliminación Gaussiana",
	#"Euler hacia Adelante",
	#"Euler hacia Atrás",
	#"Euler Modificado",
	#"Falsa Posición (Regula Falsi)",
	#"Gauss-Jordán",
	#"Gauss-Seidel",
	#"Jacobi",
	#"Lagrange",
	#"Montante",
	#"Newton hacia Adelante",
	#"Newton hacia Atrás",
	#"Newton-Cotes Abiertas",
	#"Newton-Cotes Cerradas",
	#"Newton-Raphson",
	#"Punto Fijo (o Sustituciones Sucesivas)",
	#"Regla de 1/3 de Simpson",
	#"Regla de 3/8 de Simpson",
	#"Regla del Trapecio",
	#"Runge-Kutta Cuarto Orden por 1/3 Simpson",
	#"Runge-Kutta Cuarto Orden por 3/8 Simpson",
	#"Runge-Kutta Orden Superior",
	#"Runge-Kutta Segundo Orden",
	#"Runge-Kutta Tercer Orden",
	#"Secante",
	#"Gráfico",
	#"Interpolación Lineal"
#]
#
#func _ready():
	#db = SQLite.new()
	#db.path = "res://data/banco.db"
	#db.open_db()
#
	#if not db or db == null:
		#push_error("❌ Error: no se pudo inicializar la base de datos.")
	#else:
		#print("✅ Base de datos abierta correctamente.")
#
	#randomize()
#
#func get_next_problem() -> Dictionary:
	#if current >= methods.size():
		#return {}
	#
	#var metodo = methods[current]
	#var dificultad = "Alta" if randi() % 2 == 0 else "Baja"
	#
	#var rows = db.select_rows(
		#"SELECT ProblemaDescripcion, Respuesta FROM Questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1",
		#[metodo, dificultad]
	#)
	#
	#if rows.size() > 0:
		#current_row = rows[0]
	#else:
		#current_row = {
			#"ProblemaDescripcion": "No hay problema disponible",
			#"Respuesta": "Sin respuesta"
		#}
#
	#return current_row
#
#func advance_to_next():
	#current += 1
	#if current >= methods.size():
		#get_tree().change_scene("res://scripts/End.tscn")
	#else:
		#get_tree().change_scene("res://scripts/Problem.tscn")


#extends Node
#class_name GameManager
#
#var db : SQLite
#var current = 0
#var current_row = {}
#
#var methods = [
	#"Bisectriz",
	#"Diferencias Divididas",
	#"Eliminación Gaussiana",
	#"Euler hacia Adelante",
	#"Euler hacia Atrás",
	#"Euler Modificado",
	#"Falsa Posición (Regula Falsi)",
	#"Gauss-Jordán",
	#"Gauss-Seidel",
	#"Jacobi",
	#"Lagrange",
	#"Montante",
	#"Newton hacia Adelante",
	#"Newton hacia Atrás",
	#"Newton-Cotes Abiertas",
	#"Newton-Cotes Cerradas",
	#"Newton-Raphson",
	#"Punto Fijo (o Sustituciones Sucesivas)",
	#"Regla de 1/3 de Simpson",
	#"Regla de 3/8 de Simpson",
	#"Regla del Trapecio",
	#"Runge-Kutta Cuarto Orden por 1/3 Simpson",
	#"Runge-Kutta Cuarto Orden por 3/8 Simpson",
	#"Runge-Kutta Orden Superior",
	#"Runge-Kutta Segundo Orden",
	#"Runge-Kutta Tercer Orden",
	#"Secante",
	#"Gráfico",
	#"Interpolación Lineal"
#]
#
#var db  # Declaración global
#
#func _ready():
	#db = SQLite.new()  # Solo asignación aquí, sin var
	#var result = db.open_db("res://data/banco.db")
	#
#func get_next_problem() -> Dictionary:
	#var method_name = methods[current]
	#var dificultad = "Alta" if randi() % 2 == 0 else "Baja"
#
	#var query = "SELECT ProblemaDescripcion, Respuesta, SolutionImage FROM Questions WHERE Metodo = ? AND Dificultad = ? ORDER BY RANDOM() LIMIT 1"
	#db.query_with_args(query, [method_name, dificultad])
#
	#if db.query_result.size() > 0:
		#current_row = db.query_result[0]
	#else:
		#current_row = {
			#"ProblemaDescripcion": "Sin problema.",
			#"Respuesta": "Sin respuesta.",
			#"SolutionImage": ""
		#}
#
	#return current_row
#
#func advance_to_next():
	#current += 1
	#if current >= methods.size():
		#get_tree().change_scene_to_file("res://scripts/End.tscn")
	#else:
		#get_tree().reload_current_scene()
