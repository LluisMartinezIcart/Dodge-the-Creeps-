extends Control

func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://SinglePlayer.tscn")

func _on_LocalMultiplayerButton_pressed():
	get_tree().change_scene("res://LocalMultiplayer.tscn")

func _on_OnlineMultiplayerButton_pressed():
	show_pending("Online multiplayer")

func _on_SettingsButton_pressed():
	show_pending("Settings")

func _on_HighscoresButton_pressed():
	show_pending("Highscores")

func _on_AboutButton_pressed():
	show_pending("About")

func show_pending(option):
	$Options/Message.text = option + ": próximamente"
