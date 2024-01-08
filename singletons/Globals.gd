extends Node

# warning-ignore:unused_class_variable
var spawnpoint = ""
var current_level = ""

func _ready():
	RenderingServer.set_default_clear_color(Color.WHITE)

"""
Really simple save file implementation. Just saving some variables to a dictionary
"""
func save_game(): 
	var savefile = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_dict = {}
	save_dict.spawnpoint = spawnpoint
	save_dict.current_level = current_level
	save_dict.inventory = Inventory.list()
	save_dict.quests = Quest.get_quest_list()
	savefile.store_line(JSON.stringify(save_dict))
	savefile.close()
	pass

"""
If check_only is true it will only check for a valid save file and return true or false without
restoring any data
"""
func load_game(check_only=false):
	
	if not FileAccess.file_exists("user://savegame.save"):
		return false
	
	var savefile = FileAccess.open("user://savegame.save", FileAccess.READ)
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(savefile.get_line())
	var save_dict = test_json_conv.get_data()
	if typeof(save_dict) != TYPE_DICTIONARY:
		return false
	if not check_only:
		_restore_data(save_dict)
	
	savefile.close()
	return true

"""
Restores data from the JSON dictionary inside the save files
"""
func _restore_data(save_dict):
	# JSON numbers are always parsed as floats. In this case we need to turn them into ints
	for key in save_dict.quests:
		save_dict.quests[key] = int(save_dict.quests[key])
	Quest.quest_list = save_dict.quests
	
	# JSON numbers are always parsed as floats. In this case we need to turn them into ints
	for key in save_dict.inventory:
		save_dict.inventory[key] = int(save_dict.inventory[key])
	Inventory.inventory = save_dict.inventory
	
	spawnpoint = save_dict.spawnpoint
	current_level = save_dict.current_level
	pass
	
