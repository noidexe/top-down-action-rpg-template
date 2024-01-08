extends PanelContainer

var enabled = false

func _ready():
	Globals.save_game()
	get_tree().set_auto_accept_quit(false)
	hide()

func _input(event):
	if event.is_action_pressed("pause"):
		enabled = !enabled
		visible = enabled
		get_tree().paused = enabled
		if enabled:
			grab_focus()
			_update_quest_listing()
			_update_item_listing()
			
func _update_quest_listing():
	var text = ""
	text += "Started:\n"
	for quest in Quest.list(Quest.STATUS.STARTED):
		text += "  %s\n" % quest
	text += "Failed:\n"
	for quest in Quest.list(Quest.STATUS.FAILED):
		text += "  %s\n" % quest
	
	$VBoxContainer/HBoxContainer/Quests/Details.text = text
	pass

func _update_item_listing():
	var text = ""
	var inventory = Inventory.list()
	if inventory.is_empty():
		text += "[Empty]"
	for item in inventory:
		text += "%s x %s\n" % [item, inventory[item]]
	$VBoxContainer/HBoxContainer/Inventory/Details.text = text
	pass



func _on_Exit_pressed():
	quit_game()
	pass # Replace with function body.

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit_game()
		
func quit_game():
	Globals.save_game()
	get_tree().quit()
