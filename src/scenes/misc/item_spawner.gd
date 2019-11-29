extends Position2D


var item_scene = preload("res://scenes/items/Item.tscn")
export(String) var item_type = "Generic Item"
export(int) var amount = 1

func _ready():
	pass

func spawn():
	var item = item_scene.instance()
	owner.get_parent().add_child(item)
	item.global_position = global_position
	item.item_type = item_type
	item.amount = amount
	pass
