extends Node

enum STATUS { NONEXISTENT, STARTED, COMPLETE, DELIVERED, FAILED }

signal quest_changed(quest_name, status)

var quest_list = {}

func get_status(quest_name:String) -> int:
	if quest_list.has(quest_name):
		return quest_list[quest_name]
	else:
		return STATUS.NONEXISTENT
	pass
	
func get_status_as_text(quest_name:String) -> int:
	var status = get_status(quest_name)
	return STATUS.keys()[status]
	
func change_status(quest_name:String, status:int) -> bool:
	if quest_list.has(quest_name):
		quest_list[quest_name] = status
		emit_signal("quest_changed", quest_name, status)
		return true
	else:
		return false
	pass
	
func accept_quest(quest_name:String) -> bool:
	if quest_list.has(quest_name):
		return false
	else:
		quest_list[quest_name] = STATUS.STARTED
		emit_signal("quest_changed", quest_name, STATUS.STARTED)
		return true
	pass
	
func list(status:int) -> Array:
	if status == -1:
		return quest_list.keys()
	var result = []
	for quest in quest_list.keys():
		if quest_list[quest] == status:
			result.append(quest)
	return result
	pass
	
func get_quest_list() -> Dictionary:
	return quest_list.duplicate()

func remove_quest(quest_name:String) -> bool:
	if quest_list.has(quest_name):
		quest_list.erase(quest_name)
		emit_signal("quest_changed", quest_name, STATUS.NONEXISTENT)
		return true
	else:
		return false
	pass
	
