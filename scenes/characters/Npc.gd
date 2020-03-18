extends Area2D

"""
It just wraps around a sequence of dialogs. If it contains a child node named 'Quest'
which should be an instance of Quest.gd it'll become a quest giver and show whatever
text Quest.process() returns
"""

var active = false

export(String) var character_name = "Nameless NPC"
export(Array, String, MULTILINE) var dialogs = ["..."]
var current_dialog = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")
	# warning-ignore:return_value_discarded
	connect("body_exited", self, "_on_body_exited")
	pass # Replace with function body.

func _input(event):
	if (
			active and not
			dialogs.empty() and
			event.is_action_pressed("interact") and not
			Dialogs.active
		):
		if has_node("Quest"):
			var quest_dialog = get_node("Quest").process()
			if quest_dialog != "":
				Dialogs.show_dialog(quest_dialog, character_name)
				return
		Dialogs.show_dialog(dialogs[current_dialog], character_name)
		current_dialog = wrapi(current_dialog + 1, 0, dialogs.size())
		
func _on_body_entered(body):
	if body is Player:
		active = true
		
func _on_body_exited(body):
	if body is Player:
		active = false
