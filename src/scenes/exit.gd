extends Area2D

class_name Exit

export(String, FILE, "*.tscn") var to_scene = ""
export(String) var spawnpoint = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Player and to_scene != "":
		Globals.spawnpoint = spawnpoint
		get_tree().change_scene(to_scene)
	pass
