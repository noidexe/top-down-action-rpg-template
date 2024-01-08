extends Node

"""
Music singleton that handles crossfading when a new song starts
and applies a low pass filter when the game is paused. Nothing too wise
"""

var current_track = ""

var music_bus

func _ready():
	music_bus = AudioServer.get_bus_index($A.bus)


func play(stream):
	if current_track == "a":
		$B.stream = load(stream)
		$anims.play("AtoB")
		current_track = "b"
	else:
		$A.stream = load(stream)
		$anims.play("BtoA")
		current_track = "a"


# Simple 'muffled music' effect on pause using a low pass filter
func _notification(what):
	if what == NOTIFICATION_PAUSED:
		AudioServer.set_bus_effect_enabled(music_bus,0,true)
		AudioServer.set_bus_volume_db(music_bus,-10)
	elif what == NOTIFICATION_UNPAUSED:
		AudioServer.set_bus_effect_enabled(music_bus,0,false)
		AudioServer.set_bus_volume_db(music_bus,0)
