extends Label

"""
Connects to the inventory and quest systems and will show a message on screen
for every change in either
"""

var messages = []


func _ready():
	hide()
	Quest.quest_changed.connect(_questlog_updated)
	Inventory.item_changed.connect(_inventory_updated)


func _questlog_updated(quest_name, status):
	var txt
	match status:
		Quest.STATUS.STARTED:
			txt = "Quest aquired: %s." % quest_name
		Quest.STATUS.COMPLETE:
			txt = "Quest complete! %s." % quest_name
	_queue_message(txt)
	pass

func _inventory_updated(action, type, amount):
	var txt
	match action:
		"added":
			txt = "Obtained %s x %s" % [type, amount]
		"removed":
			txt = "Lost %s x %s" % [type, amount]
	_queue_message(txt)
	pass

func _queue_message(p_text):
	messages.push_back(p_text)
	if not $anims.is_playing():
		_play_next()
	pass
	
func _play_next():
	if messages.is_empty():
		return
	else:
		text = messages.pop_front()
		$anims.queue("update")
