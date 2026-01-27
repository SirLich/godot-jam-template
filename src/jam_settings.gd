extends Resource
class_name JamSettings

@export var default_scene_transition : Transition

@export_group("Audio")
@export var main_menu_music : AudioStream
@export var game_music : AudioStream

@export_group("Scenes")
@export var main_menu_scene : PackedScene
@export var credits_scene : PackedScene
@export var settings_scene : PackedScene
@export var game_scene : PackedScene
@export var pause_scene : PackedScene
