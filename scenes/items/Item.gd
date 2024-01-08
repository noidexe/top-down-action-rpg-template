extends Area2D

@export var item_type: String = "Generic Item"
@export var amount: int = 1

func _ready():
	body_entered.connect(_on_Item_body_entered)
	pass

func _on_Item_body_entered(body):
	if body is Player:
		body_entered.disconnect(_on_Item_body_entered)
		Inventory.add_item(item_type, amount)
		$anims.play("collected")
	pass
