extends Node

"""
This is the Dialogs system. Any object can send text to it by doing Dialogs.show_dialog(text, speaker)

Before using it 'dialog_box' should be set to some node that implements the following
signal dialog_started
signal dialog_ended
func show_dialog(text, speaker)

This script will connect to those signals and use them to set 'active' to true or false and forward them to other nodes, 
so they can react to the dialog system being active(showing dialog) or inactive

Calls to show_dialog will be forwarded to the dialog_box which is free to implement them in any way (showing the text on screen,
using text to speech, etc)
"""

signal dialog_started
signal dialog_ended

var active = false

var dialog_box = null: set = _set_dialog_box

func show_dialog(text:String, speaker:String):
	if is_instance_valid(dialog_box):
		dialog_box.show_dialog(text, speaker)

func _set_dialog_box(node):
	if not node is Node:
		push_error("provided node doesn't extend Node")
		return
	
	dialog_box = node
	
	if dialog_box.get_script().has_script_signal("dialog_started"):
		dialog_box.dialog_started.connect(_on_dialog_started)
	else:
		push_error("provided node doesn't implement dialog_started signal")
	
	if dialog_box.get_script().has_script_signal("dialog_ended"):
		dialog_box.dialog_ended.connect(_on_dialog_ended)
	else:
		push_error("provided node doesn't implement dialog_started signal")
	
	pass
	
func _on_dialog_started():
	active = true
	emit_signal("dialog_started")
	
func _on_dialog_ended():
	active = false
	emit_signal("dialog_ended")
