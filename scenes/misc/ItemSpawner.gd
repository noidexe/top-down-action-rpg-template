extends Marker2D

"""
Add this to any node. spawn instances an Item.tscn node with the defined values
"""


var item_scene = preload("res://scenes/items/Item.tscn")
@export var item_type: String = "Generic Item"
@export var amount: int = 1


func spawn():
	var item = item_scene.instantiate()
	owner.get_parent().add_child(item)
	item.global_position = global_position
	item.item_type = item_type
	item.amount = amount
	pass
