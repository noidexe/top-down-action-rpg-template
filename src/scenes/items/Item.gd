extends Area2D

export(String) var item_type = "Generic Item"
export(int) var amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Item_body_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body):
	if body is Player:
		disconnect("body_entered", self, "_on_Item_body_entered")
		Inventory.add_item(item_type, amount)
		$anims.play("collected")
	pass # Replace with function body.
