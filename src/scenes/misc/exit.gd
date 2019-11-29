extends Area2D

class_name Exit

export(String, FILE, "*.tscn") var to_scene = ""
export(String) var spawnpoint = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player:
		if  to_scene == "":
			push_error("Error al cambiar de escena: to_scene no tiene niguna escena asignada")
			return false
		Globals.spawnpoint = spawnpoint
		if get_tree().change_scene(to_scene) != OK:
			push_error("Error al cambiar de escena")
	pass
