extends Area2D

export(String) var item_type = "Generic Item"
export(int) var amount = 1

func _ready():
	connect("body_entered", self, "_on_Item_body_entered")
	pass

func _on_Item_body_entered(body):
	if body is Player:
		call_deferred("disconnect", "body_entered", self, "_on_Item_body_entered")
		Inventory.add_item(item_type, amount)
		$anims.play("collected")
	pass
