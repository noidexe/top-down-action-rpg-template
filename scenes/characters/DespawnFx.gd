extends CPUParticles2D

func _ready():
	emitting = true
	await get_tree().create_timer(0.8).timeout
	queue_free()
	pass # Replace with function body.

