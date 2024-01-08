extends CanvasLayer

"""
This can be added to any scene and be use to show some properties for debug purposes
"""

@export var path_to_node: NodePath
@export var properties = [] # (Array, String)
@export var enabled: bool = true: get = _get_enabled, set = _set_enabled

var node = null

@onready var stats = $Control/stats

# Called when the node enters the scene tree for the first time.
func _ready():
	node = get_node(path_to_node)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var output = ""
	for property in properties:
		if not property in node:
			printerr("Property %s not found in %s" % [property, node])
			properties.erase(property)
			continue
		output += property + ": " + str(node[property]) + "\n"
	stats.text = output
	pass

func _set_enabled(value):
	enabled = value
	if value == true:
		$Control.show()
		set_process(true)
	else:
		$Control.hide()
		set_process(false)
	
func _get_enabled():
	return enabled
