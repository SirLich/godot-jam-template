extends "res://addons/sound_manager/sound_manager.gd"

func _ready() -> void:
	set_default_ambient_sound_bus("Ambient")
	set_default_music_bus("Music")
	set_default_sound_bus("Sound")
	set_default_ui_sound_bus("UserInterface")
	
