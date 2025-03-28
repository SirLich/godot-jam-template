extends Control
class_name MainMenu

@export var play_button : BaseButton
@export var settings_button : BaseButton
@export var credits_button : BaseButton

	
func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	settings_button.pressed.connect(on_settings_pressed)
	credits_button.pressed.connect(on_credits_pressed)

func on_play_pressed():
	pass
	
func on_settings_pressed():
	pass
	
func on_credits_pressed():
	SceneManager.change_to_packed_with_default_transition(Global.settings.credits_scene)
