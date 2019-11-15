extends TextureRect
class_name DialogBox

onready var dialog_text = $dialog_text

signal dialog_started
signal dialog_ended

var total_lines = 0
var lines_to_skip = 0

func _ready():
	Dialogs.dialog_box = self
	hide()
	pass # Replace with function body.

func show_dialog(new_text, speaker):
	dialog_text.text = new_text
	$nametag/label.text = speaker
	total_lines = dialog_text.get_line_count()
	lines_to_skip = 0
	dialog_text.lines_skipped = lines_to_skip
	$anims.play("appear")
	pass

func _input(event):
	if event.is_action_pressed("interact"):
		match $anims.assigned_animation:
			"show_text": 
				$anims.play("wait")
			"wait":
				lines_to_skip += 2
				if lines_to_skip < total_lines: 
					dialog_text.lines_skipped = lines_to_skip
					$anims.play("show_text")
				else:
					$anims.play("disappear")
