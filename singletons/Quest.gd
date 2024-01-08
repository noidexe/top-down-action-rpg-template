extends Node

"""
Minimal quest system implementation.

A dictionary where each string key represents a quest and an int value represanting a status
"""

enum STATUS { NONEXISTENT, STARTED, COMPLETE, FAILED }


# Emitted whenever a quests changes. It'll pass the quest name and new status
signal quest_changed(quest_name, status)

var quest_list = {}

# Get the status of a quest. If it's not found it returns STATUS.NONEXISTENT
func get_status(quest_name:String) -> int:
	if quest_list.has(quest_name):
		return quest_list[quest_name]
	else:
		return STATUS.NONEXISTENT


func get_status_as_text(quest_name:String) -> int:
	var status = get_status(quest_name)
	return STATUS.keys()[status]


# Change the state of some quest. status should be Quests.STATUS.<some status>
func change_status(quest_name:String, status:int) -> bool:
	if quest_list.has(quest_name):
		quest_list[quest_name] = status
		emit_signal("quest_changed", quest_name, status)
		return true
	else:
		return false


# Start a new quest
func accept_quest(quest_name:String) -> bool:
	if quest_list.has(quest_name):
		return false
	else:
		quest_list[quest_name] = STATUS.STARTED
		emit_signal("quest_changed", quest_name, STATUS.STARTED)
		return true


# List all the quest in a certain status
func list(status:int) -> Array:
	if status == -1:
		return quest_list.keys()
	var result = []
	for quest in quest_list.keys():
		if quest_list[quest] == status:
			result.append(quest)
	return result


func get_quest_list() -> Dictionary:
	return quest_list.duplicate()


# Remove a quest from the list of quests
func remove_quest(quest_name:String) -> bool:
	if quest_list.has(quest_name):
		quest_list.erase(quest_name)
		emit_signal("quest_changed", quest_name, STATUS.NONEXISTENT)
		return true
	else:
		return false

