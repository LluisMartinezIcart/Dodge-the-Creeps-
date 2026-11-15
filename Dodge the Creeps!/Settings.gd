extends Control

func _ready():
	$ColorRect/Options/VolumeSlider.value = GameSettings.volume_percent
	$ColorRect/Options/MuteCheckButton.pressed = GameSettings.muted
	$ColorRect/Options/FullscreenCheckButton.pressed = GameSettings.fullscreen

func _on_VolumeSlider_value_changed(value):
	GameSettings.volume_percent = value
	GameSettings.save_and_apply()

func _on_MuteCheckButton_toggled(button_pressed):
	GameSettings.muted = button_pressed
	GameSettings.save_and_apply()

func _on_FullscreenCheckButton_toggled(button_pressed):
	GameSettings.fullscreen = button_pressed
	GameSettings.save_and_apply()

func _on_BackButton_pressed():
	get_tree().change_scene("res://Menu.tscn")
