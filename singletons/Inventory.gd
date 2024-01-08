extends Node

"""
Minimal inventory system implementation. 
It's just a dictionary where items are identified by a string key and hold an int amount
"""

# action can be 'added' some amount of some items is added and 'removed' when some amount
# of some item is removed
signal item_changed(action, type, amount)

var inventory = {}


func get_item(type:String) -> int:
	if inventory.has(type):
		return inventory[type]
	else:
		return 0


func add_item(type:String, amount:int) -> bool:
	if inventory.has(type):
		inventory[type] += amount
		emit_signal("item_changed", "added", type, amount)
		return true
	else:
		inventory[type] = amount
		emit_signal("item_changed", "added", type, amount)
		return true


func remove_item(type:String, amount:int) -> bool:
	if inventory.has(type) and inventory[type] >= amount:
		inventory[type] -= amount
		if inventory[type] == 0:
			inventory.erase(type)
		emit_signal("item_changed", "removed", type, amount)
		return true
	else:
		return false


func list() -> Dictionary:
	return inventory.duplicate()
