extends Control

func _ready():
	var master_sound = AudioServer.get_bus_index("Master")
	var isMusicOn = AudioServer.is_bus_mute(master_sound)
	$PopupPanel/CheckButton.pressed = !isMusicOn



func _on_CheckButton_toggled(button_pressed):
	print(button_pressed)
	Globals.emit_signal("music_changed", button_pressed)
	$PopupPanel/CheckButton.release_focus()
	pass # Replace with function body.
