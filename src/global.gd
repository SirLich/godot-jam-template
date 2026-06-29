extends Node

var settings : JamSettings = load("res://resources/settings.tres")
static var _preferences_path = "user://preferences.cfg"

static func get_preferences() -> ConfigFile:
	var preferences = ConfigFile.new()
	preferences.load(_preferences_path)
	return preferences
	
## Call this on startup to load and apply user preferences
static func initialize_from_user_preferences() -> void:
	var preferences = get_preferences()
	
	_initialize_volume_preference(preferences, "Master")
	_initialize_volume_preference(preferences, "Music")
	_initialize_volume_preference(preferences, "Sounds")

static func get_volume_preference(bus_name: String) -> float:
	var preferences = get_preferences()
	return preferences.get_value("preferences", bus_name, 0.8)
	
static func set_volume_preference(bus_name: String, value: float) -> void:
	var preferences = get_preferences()
	preferences.set_value("preferences", bus_name, value)
	preferences.save(_preferences_path)
	
static func _initialize_volume_preference(preferences: ConfigFile, bus_name: String) -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_linear(bus_index, preferences.get_value("preferences", bus_name, 0.8))
