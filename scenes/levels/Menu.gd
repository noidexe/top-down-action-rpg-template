extends Control

export(String, FILE, "*.tscn") var initial_level = ""

func _ready():
	grab_focus()
	if Globals.load_game(true):
		$continue.disabled = false
	else:
		$continue.disabled = true


func _on_continue_pressed():
	Globals.load_game()
	if Globals.current_level != "":
		if get_tree().change_scene(Globals.current_level) != OK:
			push_error("Error changing scenes")
	else:
		push_error("Error: current_level shouldn't be empty")
	pass # Replace with function body.


func _on_new_game_pressed():
	if initial_level != "":
		Globals.current_level = initial_level
		if Globals.save_game() == false:
			push_error("Error saving game")
		var err = get_tree().change_scene(initial_level)
		if err != OK:
			push_error("Error changing scene: %s" % err)
	else:
		push_error("Error: initial_level shouldn't be empty")
		
	pass # Replace with function body.




func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_controls_pressed():
	get_tree().change_scene("res://scenes/levels/Controls.tscn")
	pass # Replace with function body.
