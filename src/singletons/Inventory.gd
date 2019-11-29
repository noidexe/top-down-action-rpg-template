extends Node

signal item_changed(action, type, amount)

var inventory = {}

func get_item(type:String) -> int:
	if inventory.has(type):
		return inventory[type]
	else:
		return 0
	pass
	
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
	pass
	
func list() -> Dictionary:
	return inventory.duplicate()
