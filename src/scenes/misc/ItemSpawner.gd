extends Position2D

"""
Add this to any node. spawn instances an Item.tscn node with the defined values
"""


var item_scene = preload("res://scenes/items/Item.tscn")
export(String) var item_type = "Generic Item"
export(int) var amount = 1


func spawn():
	var item = item_scene.instance()
	owner.get_parent().add_child(item)
	item.global_position = global_position
	item.item_type = item_type
	item.amount = amount
	pass
