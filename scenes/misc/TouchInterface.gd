extends Node2D



func _ready():
	Dialogs.dialog_started.connect(_on_dialog_started)
	Dialogs.dialog_ended.connect(_on_dialog_ended)


func _on_dialog_started():
	for child in get_children():
		child.hide()
	$interact.show()

func _on_dialog_ended():
	for child in get_children():
		child.show()


func _notification(what):
	if what == NOTIFICATION_PAUSED:
		for child in get_children():
			child.hide()
		$stats.show()
	elif what == NOTIFICATION_UNPAUSED:
		for child in get_children():
			child.show()
