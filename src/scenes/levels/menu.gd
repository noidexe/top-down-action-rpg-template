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
			push_error("Error al cambiar de escena")
	else:
		push_error("Error: current_level no deberia estar vacio")
	pass # Replace with function body.


func _on_credits_pressed():
	#get_tree().change_scene("ruta a escena de creditos")
	pass


func _on_new_game_pressed():
	if initial_level != "":
		Globals.current_level = initial_level
		if Globals.save_game() == false:
			push_error("Error al grabar la partida")
		if get_tree().change_scene(initial_level) != OK:
			push_error("Error al cambiar de escena")
	else:
		push_error("Error: initial_level no deberia estar vacio")
		
	pass # Replace with function body.




func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
