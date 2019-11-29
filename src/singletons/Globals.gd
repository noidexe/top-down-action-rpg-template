extends Node

# warning-ignore:unused_class_variable
var spawnpoint = ""
var current_level = ""

func _ready():
	VisualServer.set_default_clear_color(ColorN("white"))

func save_game(): 
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_dict = {}
	save_dict.spawnpoint = spawnpoint
	save_dict.current_level = current_level
	save_dict.inventory = Inventory.list()
	save_dict.quests = Quest.get_quest_list()
	save_game.store_line(to_json(save_dict))
	save_game.close()
	pass
	

func load_game(check_only=false):
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return false
	
	save_game.open("user://savegame.save", File.READ)
	var save_dict = parse_json(save_game.get_line())
	if typeof(save_dict) != TYPE_DICTIONARY:
		return false
	if not check_only:
		_restore_data(save_dict)
	save_game.close()
	return true

func _restore_data(save_dict):
	Quest.quest_list = save_dict.quests
	Inventory.inventory = save_dict.inventory
	spawnpoint = save_dict.spawnpoint
	current_level = save_dict.current_level
	pass
	
