extends Area2D

class_name Exit

"""
Add this to any area2d and it will send the player to the indicated scene and spawnpoint
"""

@export var to_scene = "" # (String, FILE, "*.tscn")
@export var spawnpoint: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered, CONNECT_DEFERRED)

func _on_body_entered(body):
	if body is Player:
		if  to_scene == "":
			push_error("Error changing scenes: to_scene has no assigned scene")
			return false
		Globals.spawnpoint = spawnpoint
		Globals.current_level = to_scene
		if get_tree().change_scene_to_file(to_scene) != OK:
			push_error("Error changing scene")
	pass
