extends HBoxContainer

"""
Connects to the player node and shows a health bar in the form of hearts
"""

var player : Player = null
var heart_scene = preload("res://scenes/misc/Heart.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	# Try to get the player node. If null wait till next frame, rinse, repeat.
	while (player == null):
		var player_group = get_tree().get_nodes_in_group("player")
		if not player_group.is_empty():
			player = player_group.pop_front()
		else:
			await get_tree().idle_frame
	
	player.health_changed.connect(_on_health_changed)
	_on_health_changed(player.hitpoints)
	pass # Replace with function body.


# You should probably rewrite this.
func _on_health_changed(new_hp):
	for child in get_children():
		child.queue_free()
	for i in new_hp:
		var heart = heart_scene.instantiate()
		add_child(heart)
	
