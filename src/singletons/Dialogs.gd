extends Node

signal dialog_started
signal dialog_ended

var active = false

var dialog_box = null setget _set_dialog_box

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_dialog(text, speaker):
	if is_instance_valid(dialog_box):
		dialog_box.show_dialog(text, speaker)

func _set_dialog_box(node):
	if not node is DialogBox:
		return
	dialog_box = node
	dialog_box.connect("dialog_started", self, "_on_dialog_started")
	dialog_box.connect("dialog_ended", self, "_on_dialog_ended")
	pass
	
func _on_dialog_started():
	active = true
	emit_signal("dialog_started")
	
func _on_dialog_ended():
	active = false
	emit_signal("dialog_ended")
