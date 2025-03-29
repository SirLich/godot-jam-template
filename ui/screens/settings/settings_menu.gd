extends Control
class_name SettingsMenu

@export var back_button : BaseButton

func _ready() -> void:
	back_button.pressed.connect(on_back_pressed)

func on_back_pressed():
	SceneManager.change_to_packed_with_default_transition(Global.settings.main_menu_scene)
