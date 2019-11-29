extends Node

enum STATUS { STARTED, COMPLETE, FAILED, NONEXISTENT }

signal quest_changed(quest_name, status)

var quest_list = {}

func get_status(quest_name):
	if quest_list.has(quest_name):
		return quest_list[quest_name]
	else:
		return STATUS.NONEXISTENT
	pass
	
func change_status(quest_name, status):
	if quest_list.has(quest_name):
		quest_list[quest_name] = status
		emit_signal("quest_changed", quest_name, status)
		return true
	else:
		return false
	pass
	
func accept_quest(quest_name):
	if quest_list.has(quest_name):
		return false
	else:
		quest_list[quest_name] = STATUS.STARTED
		emit_signal("quest_changed", quest_name, STATUS.STARTED)
		return true
	pass
	
func list(status):
	var result = []
	for quest in quest_list.keys():
		if quest_list[quest] == status:
			result.append(quest)
	return result
	pass

func remove_quest(quest_name):
	if quest_list.has(quest_name):
		quest_list.erase(quest_name)
		emit_signal("quest_changed", quest_name, STATUS.NONEXISTENT)
		return true
	else:
		return false
	pass
	

