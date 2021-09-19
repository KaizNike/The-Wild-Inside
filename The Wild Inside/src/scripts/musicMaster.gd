extends Node

func _ready():
	Globals.connect("music_changed", self, "change_music")

func change_music(value):
	if value == true:
		var master_sound = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_sound, false)
	if value == false:
		var master_sound = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_sound, true)
