extends Node

func _ready():
	$AudioStreamPlayer.play(1)
	
	
func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/scenes/SoccerTest.tscn")

#
#func _on_Options_pressed():
##	$GameUI/PopupPanel.popup()
#	pass # Replace with function body.
