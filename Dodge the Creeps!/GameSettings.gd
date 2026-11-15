extends Node

const CONFIG_PATH = "user://settings.cfg"

var volume_percent = 100.0
var muted = false
var fullscreen = false

func _ready():
	load_settings()

func load_settings():
	var config = ConfigFile.new()
	var error = config.load(CONFIG_PATH)

	if error == OK:
		volume_percent = config.get_value("audio", "volume_percent", 100.0)
		muted = config.get_value("audio", "muted", false)
		fullscreen = config.get_value("display", "fullscreen", false)

	apply_settings()

func save_settings():
	var config = ConfigFile.new()

	config.set_value("audio", "volume_percent", volume_percent)
	config.set_value("audio", "muted", muted)
	config.set_value("display", "fullscreen", fullscreen)

	config.save(CONFIG_PATH)

func apply_settings():
	var master_bus = AudioServer.get_bus_index("Master")

	AudioServer.set_bus_mute(master_bus, muted)

	if volume_percent <= 0:
		AudioServer.set_bus_volume_db(master_bus, -80)
	else:
		AudioServer.set_bus_volume_db(master_bus, linear2db(volume_percent / 100.0))

	OS.window_fullscreen = fullscreen

func save_and_apply():
	save_settings()
	apply_settings()
