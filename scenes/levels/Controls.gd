extends Control


func _ready():
	$Button.grab_focus()
	pass


func _on_Button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/Menu.tscn")
	pass # Replace with function body.
